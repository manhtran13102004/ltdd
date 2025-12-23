import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/features/shop/controllers/cart/cart_controller.dart';
import 'package:project/features/shop/models/product_model.dart';
import 'package:project/utils/constants/colors.dart';
import 'package:project/utils/constants/sizes.dart';
import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class TButtonAddToCart extends StatelessWidget {
  final ProductModel product;

  const TButtonAddToCart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartController = Get.put(CartController());

    // Khai báo quantity 1 lần duy nhất, dùng RxInt để realtime
    final RxInt quantity = 1.obs;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? TColors.darkGrey : TColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Phần số lượng: chỉ dùng 1 Obx bao hết
          Obx(() => Row(
            children: [
              TCircularIcon(
                icon: Iconsax.minus,
                backgroundColor: TColors.primary,
                width: 40,
                height: 40,
                color: TColors.white,
                onPressed: () {
                  if (quantity.value > 1) {
                    quantity.value--;
                  }
                },
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text(
                '${quantity.value}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              TCircularIcon(
                icon: Iconsax.add,
                backgroundColor: TColors.primary,
                width: 40,
                height: 40,
                color: TColors.white,
                onPressed: () {
                  quantity.value++;
                },
              ),
            ],
          )),

          // Nút thêm vào giỏ hàng
          ElevatedButton(
            onPressed: () {
              cartController.addToCart(product, quantity.value);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: TColors.primary,
              side: const BorderSide(color: TColors.primary),
            ),
            child: const Text('Thêm vào giỏ hàng'),
          ),
        ],
      ),
    );
  }
}