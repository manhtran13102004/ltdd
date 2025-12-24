import 'package:flutter/material.dart';
import 'package:project/features/shop/models/brand_model.dart';
import 'package:project/utils/constants/colors.dart';
import 'package:project/utils/constants/sizes.dart';
import 'package:project/utils/helpers/helper_functions.dart';
import 'package:project/common/widgets/images/t_rounded_image.dart';
import '../containers/rounded_container.dart';
import 'brandcard.dart';

class TBrandShowcase extends StatelessWidget {
  final BrandModel brand;
  final List<String> images; // List URL ảnh sản phẩm nổi bật của brand

  const TBrandShowcase({super.key, required this.brand, required this.images});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      showBorder: true,
      borderColor: TColors.darkGrey,
      backgroundColor: TColors.white,
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      padding: const EdgeInsets.all(TSizes.md),
      child: Column(
        children: [
          // Header brand card
          TBrandCard(brand: brand),

          const SizedBox(height: TSizes.spaceBtwItems),

          // 3 ảnh sản phẩm nổi bật
          Row(
            children: images
                .take(3)
                .map((image) => Expanded(
              child: TRoundedContainer(
                height: 100,
                backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.dark : TColors.light,
                margin: const EdgeInsets.only(right: TSizes.sm),
                padding: const EdgeInsets.all(TSizes.sm),
                child: TRoundedImage(
                  imageUrl: image,
                  isNetworkImage: true,
                  fit: BoxFit.contain,
                ),
              ),
            ))
                .toList(),
          ),
        ],
      ),
    );
  }
}