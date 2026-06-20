import 'package:flutter/material.dart';

/// 星级评分 widget（1-5 星）
///
/// - 只读模式（[onRatingChanged] 为 null）：按 [rating] 显示实心/空心星
/// - 可点选模式：点击第 N 颗星触发 [onRatingChanged](N)
class StarRating extends StatelessWidget {
  /// 当前评分（0-5）
  final int rating;

  /// 星星尺寸
  final double size;

  /// 实心星颜色（默认琥珀）
  final Color? color;

  /// 空心星颜色
  final Color? emptyColor;

  /// 点击回调；为 null 时只读
  final ValueChanged<int>? onRatingChanged;

  /// 星星总数
  final int starCount;

  const StarRating({
    super.key,
    required this.rating,
    this.size = 16,
    this.color,
    this.emptyColor,
    this.onRatingChanged,
    this.starCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    const filled = Color(0xFFFFC107);
    final empty = emptyColor ?? Colors.grey[400]!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (i) {
        final index = i + 1;
        final isFilled = index <= rating;
        return GestureDetector(
          onTap: onRatingChanged == null ? null : () => onRatingChanged!(index),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size * 0.06),
            child: Icon(
              isFilled ? Icons.star : Icons.star_border,
              size: size,
              color: isFilled ? (color ?? filled) : empty,
            ),
          ),
        );
      }),
    );
  }
}
