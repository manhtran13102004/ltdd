import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../features/shop/models/cart_item_model.dart';
import '../../images/t_rounded_image.dart';
import '../../texts/product_title_text.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
    required this.item,
  });
  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    final isNetworkImage = item.image.startsWith('http');
    final attributeText = item.attributesLabel;
    return Row(
      children: [
        TRoundedImage(
          imageUrl: item.image,
          width: 70,
          height: 70,
          padding: const EdgeInsets.all(TSizes.sm),
          backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkGrey : TColors.light,
          isNetworkImage: isNetworkImage,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        Expanded(

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: TProductTitleText(title: item.title, maxLines: 1)),
              if (attributeText.isNotEmpty)
                Text(
                  attributeText,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
            ],
          ),
        )



      ],
    );
  }
}
