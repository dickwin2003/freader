import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:freader/ui/pages/ai_assistant/ai_assistant_page.dart';
import 'package:freader/ui/pages/ai_translate/ai_translate_page.dart';

/// AI hub 页 - 整合「助手」「翻译」两个入口（零侵入 push 子页）。
class AiHubPage extends ConsumerWidget {
  const AiHubPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _EntryCard(
            icon: Icons.smart_toy_outlined,
            color: const Color(0xFF1976D2),
            title: 'AI 阅读助手',
            subtitle: '章节速读、全书梗概、人物梳理、自由问答、拍照取字',
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const AiAssistantPage())),
          ),
          const SizedBox(height: 12),
          _EntryCard(
            icon: Icons.translate_outlined,
            color: const Color(0xFF388E3C),
            title: '翻译',
            subtitle: '文本翻译、拍照取字(OCR)、语音输入、朗读(Edge TTS)',
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const AiTranslatePage())),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline,
                      size: 18, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '助手按当前在读的书做摘要/问答；翻译含拍照取字与语音，适合旅行。'
                      '二者均走「我的 → AI 设置」配置的模型（云端或本地 Gemma）。',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EntryCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _EntryCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ]),
        ),
      ),
    );
  }
}
