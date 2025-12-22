import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/screens/cart/cart.dart';
import '../../../../features/shop/controllers/cart/cart_controller.dart';
import '../../../../utils/constants/colors.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    required this.iconColor,
    required this.iconColor2,
    this.onPressed,
  });
  final Color iconColor;
  final Color iconColor2;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Stack(
      children: [
        IconButton(
          onPressed: onPressed ?? () => Get.to(() => const CartScreen()),
          icon: Icon(Iconsax.shopping_bag, color: iconColor),
        ),
        Positioned(
          right: 0,
          child: Obx(() {
            final count = controller.totalItems;
            if (count <= 0) {
              return const SizedBox.shrink();
            }
            return Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  count.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: iconColor2, fontSizeFactor: 0.8),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}


