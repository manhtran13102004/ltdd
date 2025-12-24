import 'package:flutter/material.dart';
import 'package:project/utils/constants/colors.dart';

class TProductPriceText extends StatelessWidget {
  const TProductPriceText({
    super.key,
    this.currencySign = '.000 VND',
    required this.price,
    this.maxLines = 1,
    this.color,               // ← ĐÃ CÓ THAM SỐ COLOR RỒI, GIỮ NGUYÊN
    this.isLarge = false,
    this.lineThrough = false,
    this.isSmall = false,
  });

  final String currencySign, price;
  final int maxLines;
  final Color? color;         // ← GIỮ NGUYÊN
  final bool isLarge;
  final bool isSmall;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      price + currencySign,
      maxLines: maxLines,
      overflow: isLarge ? TextOverflow.visible : TextOverflow.ellipsis,
      softWrap: true,
      textAlign: TextAlign.left, // ← GIỮ NGUYÊN CĂN TRÁI NHƯ CŨ (nếu mày muốn căn phải thì đổi ở đây)

      // ÁP DỤNG MÀU MỚI VÀO STYLE, GIỮ NGUYÊN TOÀN BỘ LOGIC CŨ
      style: (isLarge
          ? Theme.of(context).textTheme.headlineMedium
          : isSmall
          ? Theme.of(context).textTheme.headlineSmall
          : Theme.of(context).textTheme.titleSmall)
          ?.apply(
        color: color, // ← ƯU TIÊN MÀU TRUYỀN VÀO
        decoration: lineThrough ? TextDecoration.lineThrough : null,
      ),
    );
  }
}