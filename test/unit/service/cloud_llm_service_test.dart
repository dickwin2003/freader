import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:freader/service/llm/cloud_llm_service.dart';
import 'package:freader/service/llm/llm_config.dart';
import 'package:freader/service/llm/llm_service.dart';

class _MockDio extends Mock implements Dio {}

void main() {
  late _MockDio dio;
  const cfg = LlmConfig(
    baseUrl: 'https://api.example.com/v1',
    apiKey: 'sk-test',
    model: 'gpt-4o-mini',
    temperature: 0.5,
    systemPrompt: '你是阅读助手',
  );

  setUp(() {
    dio = _MockDio();
    registerFallbackValue(RequestOptions(path: ''));
  });

  test('chat 拼装请求并解析 choices[0].message.content', () async {
    when(() => dio.post<dynamic>(any(),
            data: any(named: 'data'),
            options: any(named: 'options')))
        .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 200,
              data: {
                'choices': [
                  {'message': {'content': '这是摘要'}}
                ]
              },
            ));

    final svc = CloudLlmService(dio, cfg);
    final reply = await svc.chat(userPrompt: '摘要这段', systemPrompt: '速读');

    expect(reply, '这是摘要');

    final urls =
        verify(() => dio.post<dynamic>(captureAny(),
                data: any(named: 'data'),
                options: any(named: 'options')))
            .captured;
    // baseUrl 不以 / 结尾时应自动补 /chat/completions
    expect(urls.single, 'https://api.example.com/v1/chat/completions');
  });

  test('chat 在配置不全时抛 notConfigured 且不发请求', () async {
    final svc = CloudLlmService(
        dio, const LlmConfig(baseUrl: '', apiKey: '', model: ''));
    expect(() => svc.chat(userPrompt: 'hi'), throwsA(isA<LlmException>()));
    verifyNever(() => dio.post<dynamic>(any(),
        data: any(named: 'data'), options: any(named: 'options')));
  });

  test('401 映射为友好文案（含服务端 message）', () async {
    when(() => dio.post<dynamic>(any(),
            data: any(named: 'data'),
            options: any(named: 'options')))
        .thenThrow(DioException(
      requestOptions: RequestOptions(path: ''),
      type: DioExceptionType.badResponse,
      response: Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 401,
        data: {'error': {'message': 'invalid api key'}},
      ),
    ));

    final svc = CloudLlmService(dio, cfg);
    try {
      await svc.chat(userPrompt: 'hi');
      fail('应抛 LlmException');
    } on LlmException catch (e) {
      expect(e.message, contains('API Key 无效'));
      expect(e.message, contains('invalid api key'));
    }
  });

  test('空 choices 抛结果为空', () async {
    when(() => dio.post<dynamic>(any(),
            data: any(named: 'data'),
            options: any(named: 'options')))
        .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 200,
              data: {'choices': []},
            ));
    final svc = CloudLlmService(dio, cfg);
    expect(() => svc.chat(userPrompt: 'hi'), throwsA(isA<LlmException>()));
  });

  test('chatWithImage 在云端后端抛 LlmException', () async {
    final svc = CloudLlmService(dio, cfg);
    expect(
        () => svc.chatWithImage(
            userPrompt: 'x', image: Uint8List.fromList([1, 2, 3])),
        throwsA(isA<LlmException>()));
  });

  test('Anthropic 协议：POST {base}/messages、Bearer 鉴权、解析 content[*].text',
      () async {
    final anthrCfg = LlmConfig(
      baseUrl: 'https://api.longcat.chat/anthropic/v1',
      apiKey: 'ak-test',
      model: 'LongCat-2.0-Preview',
      protocol: LlmProtocol.anthropic,
    );
    when(() => dio.post<dynamic>(any(),
            data: any(named: 'data'),
            options: any(named: 'options')))
        .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(path: ''),
              statusCode: 200,
              data: {
                'content': [
                  {'type': 'text', 'text': '你好'}
                ]
              },
            ));

    final svc = CloudLlmService(dio, anthrCfg);
    final reply = await svc.chat(userPrompt: 'hi', systemPrompt: 'sys');

    expect(reply, '你好');
    final urls =
        verify(() => dio.post<dynamic>(captureAny(),
                data: any(named: 'data'),
                options: any(named: 'options')))
            .captured;
    expect(urls.single, 'https://api.longcat.chat/anthropic/v1/messages');
  });
}
