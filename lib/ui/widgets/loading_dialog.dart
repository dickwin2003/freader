import 'package:flutter/material.dart';

/// 通用加载对话框：展示一个不可关闭的旋转提示，待 [future] 完成后自动关闭。
///
/// 用法：`await showLoadingDialog(context, myFuture, message: '处理中…', onError: (e){...});`
class LoadingDialog extends StatefulWidget {
  final Future<dynamic> future;
  final String message;
  final void Function(String error)? onError;

  const LoadingDialog({
    super.key,
    required this.future,
    required this.message,
    this.onError,
  });

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog> {
  @override
  void initState() {
    super.initState();
    widget.future.then((_) {
      if (mounted) Navigator.pop(context);
    }).catchError((e) {
      widget.onError?.call(e.toString());
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 20),
            Expanded(
              child: Text(widget.message,
                  maxLines: 3, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}

/// 便捷函数：弹出加载对话框并等待 future。
Future<void> showLoadingDialog(
  BuildContext context,
  Future<dynamic> future, {
  required String message,
  void Function(String)? onError,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => LoadingDialog(
      future: future,
      message: message,
      onError: onError,
    ),
  );
}
