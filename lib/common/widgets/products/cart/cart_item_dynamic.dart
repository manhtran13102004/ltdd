// lib/common/widgets/products/cart/cart_item_dynamic.dart

import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/features/shop/controllers/cart/cart_controller.dart';
import 'package:project/features/shop/models/product_model.dart';
import 'package:project/utils/constants/colors.dart';
import 'package:project/utils/constants/sizes.dart';
import 'package:project/common/widgets/images/t_rounded_image.dart';
import 'package:project/common/widgets/texts/product_title_text.dart';
import 'package:project/common/widgets/texts/product_price_text.dart';
import 'package:project/utils/helpers/helper_functions.dart';
import 'package:project/common/widgets/icons/t_circular_icon.dart';

class TCartItemDynamic extends StatelessWidget {
  final CartItem cartItem;

  const TCartItemDynamic({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartController = Get.find<CartController>();

    return Row(
      children: [
        // Ảnh sản phẩm
        TRoundedImage(
          imageUrl: cartItem.product.thumbnail,
          isNetworkImage: true,
          width: 80,
          height: 80,
          backgroundColor: dark ? TColors.dark : TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        // Tên, giá, nút + -
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TProductTitleText(title: cartItem.product.title, smallSize: true),
              const SizedBox(height: TSizes.xs),
              TProductPriceText(price: cartController.getProductLowesPrice(cartItem.product)),

              const SizedBox(height: TSizes.spaceBtwItems),

              // Nút + - số lượng
              Row(
                children: [
                  TCircularIcon(
                    icon: Iconsax.minus,
                    backgroundColor: TColors.primary,
                    width: 40,
                    height: 40,
                    color: TColors.white,
                    onPressed: () {
                      if (cartItem.quantity > 1) {
                        cartItem.quantity--;
                        cartController.cartItems.refresh();
                      } else {
                        cartController.cartItems.remove(cartItem);
                      }
                    },
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Text('${cartItem.quantity}', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  TCircularIcon(
                    icon: Iconsax.add,
                    backgroundColor: TColors.primary,
                    width: 40,
                    height: 40,
                    color: TColors.white,
                    onPressed: () {
                      cartItem.quantity++;
                      cartController.cartItems.refresh();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        // ĐÃ XÓA NÚT "Thanh toán ngay" HOÀN TOÀN
      ],
    );
  }
}