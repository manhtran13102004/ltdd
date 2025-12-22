import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/products/cart/add_remove_button.dart';
import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../controllers/cart/cart_controller.dart';
import '../../../../../utils/constants/sizes.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    this.showAddRemoveButton = true,

  });
  final bool showAddRemoveButton;
  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(() {
      if (controller.cartItems.isEmpty) {
        return Center(
          child: Text('Giỏ hàng trống', style: Theme.of(context).textTheme.bodyMedium),
        );
      }
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections),
        itemCount: controller.cartItems.length,
        itemBuilder: (_, index) {
          final item = controller.cartItems[index];
          return Column(
            children: [
              TCartItem(item: item),
              if (showAddRemoveButton) const SizedBox(height: TSizes.spaceBtwItems),
              if (showAddRemoveButton)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 70),
                        TProductQuantityRemoveButton(
                          quantity: item.quantity,
                          onAdd: () => controller.updateItemQuantity(item.id, item.quantity + 1),
                          onRemove: () => controller.updateItemQuantity(item.id, item.quantity - 1),
                        ),
                      ],
                    ),
                    TProductPriceText(price: controller.formatPrice(item.totalPrice)),
                  ],
                ),
            ],
          );
        },
      );
    });
  }
}
