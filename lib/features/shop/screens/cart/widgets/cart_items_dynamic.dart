import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/features/shop/controllers/cart/cart_controller.dart';
import '../../../../../common/widgets/products/cart/cart_item_dynamic.dart';
import 'package:project/utils/constants/sizes.dart'; // ← THÊM DÒNG NÀY ĐỂ DÙNG TSizes

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
          return TCartItemDynamic(cartItem: cartController.cartItems[index]);
        },
      );
    });
  }
}