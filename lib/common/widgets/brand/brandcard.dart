import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/features/shop/models/brand_model.dart';
import 'package:project/utils/constants/colors.dart';
import 'package:project/utils/constants/sizes.dart';
import 'package:project/utils/helpers/helper_functions.dart';
import 'package:project/common/widgets/images/t_circular_image.dart';
import 'package:project/common/widgets/texts/t_brand_title_with_verified_icon.dart';
import '../containers/rounded_container.dart';
import 'package:project/utils/constants/enums.dart'; // ← THÊM DÒNG NÀY


class TBrandCard extends StatelessWidget {
  final BrandModel brand;
  final void Function()? onTap;

  const TBrandCard({super.key, required this.brand, this.onTap});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: true,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            Flexible(
              child: TCircularImage(
                image: brand.image,
                isNetworkImage: true,
                backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBrandTitleWithVerifidedIcon(
                    title: brand.name,
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    '${brand.productCount} sản phẩm',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}