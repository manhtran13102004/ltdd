// lib/features/shop/screens/cart/widgets/cart_items_dynamic.dart

import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:project/features/shop/controllers/cart/cart_controller.dart';
import 'package:project/common/widgets/products/cart/cart_item_dynamic.dart';
import 'package:project/utils/constants/sizes.dart';

class TCartItemsDynamic extends StatelessWidget {
  const TCartItemsDynamic({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Obx(() {
      if (cartController.cartItems.isEmpty) {
        return const Center(child: Text('Giỏ hàng trống'));
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: cartController.cartItems.length,
        separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
        itemBuilder: (_, index) {
          final item = cartController.cartItems[index];
          return TCartItemDynamic(cartItem: item); // Không truyền callback
        },
      );
    });
  }
}