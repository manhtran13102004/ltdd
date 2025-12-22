import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/utils/constants/colors.dart';
import 'package:project/utils/constants/enums.dart';
import 'package:project/utils/constants/sizes.dart';

import '../../../../../common/widgets/icons/t_circular_icon.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/cart/cart_controller.dart';
import '../../../controllers/product/variation_controller.dart';
import '../../../models/product_model.dart';

class TButtonAddToCart extends StatefulWidget {
  const TButtonAddToCart({super.key, required this.product});
  final ProductModel product;

  @override
  State<TButtonAddToCart> createState() => _TButtonAddToCartState();
}

class _TButtonAddToCartState extends State<TButtonAddToCart> {
  int quantity = 1;

  int _getMaxStock(VariationController controller) {
    final variation = controller.selectedVariation.value;
    if (variation.id.isNotEmpty) {
      return variation.stock;
    }
    return widget.product.stock;
  }

  void _increment(VariationController controller) {
    final maxStock = _getMaxStock(controller);
    if (maxStock > 0 && quantity >= maxStock) return;
    setState(() => quantity += 1);
  }

  void _decrement() {
    if (quantity <= 1) return;
    setState(() => quantity -= 1);
  }

  Future<void> _addToCart(VariationController controller) async {
    final isVariable = widget.product.productType == ProductType.variable.toString();
    final selectedVariation = controller.selectedVariation.value;
    if (isVariable && selectedVariation.id.isEmpty) {
      Get.snackbar('Warning', 'Please select product options.');
      return;
    }

    final attributes = controller.selectedAttributes.map(
          (key, value) => MapEntry(key, value.toString()),
    );
    await CartController.instance.addItem(
      widget.product,
      quantity: quantity,
      variation: selectedVariation.id.isEmpty ? null : selectedVariation,
      selectedAttributes: Map<String, String>.from(attributes),
    );
    setState(() => quantity = 1);
    Get.snackbar('Success', 'Added to cart.');
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final variationController = Get.isRegistered<VariationController>()
        ? VariationController.instance
        : Get.put(VariationController());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? TColors.darkGrey : TColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight:  Radius.circular(TSizes.cardRadiusLg),
        )
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Row(
           children: [
             TCircularIcon(
               icon: Iconsax.minus,
               backgroundColor: TColors.primary,
               width: 40,
               height: 40,
               color: TColors.white,
               onPressed: _decrement,
             ),
             const SizedBox(width: TSizes.spaceBtwItems ,),
             Text(quantity.toString(), style: Theme.of(context).textTheme.titleSmall,),
             const SizedBox(width: TSizes.spaceBtwItems ,),
             TCircularIcon(
               icon: Iconsax.add,
               backgroundColor: TColors.primary,
               width: 40,
               height: 40,
               color: TColors.white,
               onPressed: () => _increment(variationController),
             ),
           ],
         ),
         ElevatedButton(
           onPressed: () => _addToCart(variationController),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: TColors.primary,
              side: const BorderSide(color: TColors.primary)
            ),
           child: const Text('Thêm vào giỏ hàng'),

           ),
        ],
      ),

    );
  }
}
