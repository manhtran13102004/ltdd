import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/cart/cart_controller.dart'; // Thêm import này
import '../../../../features/shop/screens/cart/cart.dart';
import '../../../../utils/constants/colors.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    required this.iconColor,
    required this.iconColor2,
  });

  final Color iconColor;
  final Color iconColor2;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController()); // Put controller để lấy totalItems

    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => const CartScreen()),
          icon: Icon(Iconsax.shopping_bag, color: iconColor),
        ),
        Obx(() {
          final itemCount = cartController.totalItems;
          if (itemCount == 0) return const SizedBox(); // Ẩn badge nếu giỏ rỗng
          return Positioned(
            right: 0,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  '$itemCount',
                  style: Theme.of(context).textTheme.labelLarge!.apply(color: iconColor2, fontSizeFactor: 0.8),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}