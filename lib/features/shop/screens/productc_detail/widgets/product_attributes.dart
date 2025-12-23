import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/utils/constants/enums.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../common/widgets/texts/product_price_text.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../common/widgets/texts/t_brand_title_with_verified_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/product/variation_controller.dart';
import '../../../models/product_model.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = THelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    final dark = THelperFunctions.isDarkMode(context);

    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         if(controller.selectedVariation.value.id.isNotEmpty)
           TRoundedContainer(
             padding: const EdgeInsets.all(TSizes.md),
             backgroundColor: dark ? TColors.darkGrey : TColors.grey,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start, // Quan trọng: align left để giá xuống dòng đẹp
               children: [
                 const TSectionHeading(
                   textColor: TColors.black,
                   title: 'Variation',
                   showActionButton: false,
                 ),
                 const SizedBox(height: TSizes.spaceBtwItems),

                 // Phần Giá - fix overflow bằng Column + Expanded
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         const TProductTitleText(title: 'Giá:', smallSize: true),
                         if (controller.selectedVariation.value.salePrice > 0)
                           Padding(
                             padding: const EdgeInsets.only(left: TSizes.sm),
                             child: Text(
                               '${controller.selectedVariation.value.price.toStringAsFixed(0)}.000',
                               style: Theme.of(context).textTheme.titleSmall!.apply(
                                 decoration: TextDecoration.lineThrough,
                               ),
                             ),
                           ),
                       ],
                     ),
                     const SizedBox(height: 4),
                     // Giá chính (range) được wrap Expanded để tự co giãn và xuống dòng nếu cần
                     Padding(
                       padding: const EdgeInsets.only(left: TSizes.md), // Thụt vào cho đẹp
                       child: TProductPriceText(
                         price: controller.getVariationPrice(),
                         isSmall: false, // Để to hơn tí cho nổi bật
                         // Nếu widget TProductPriceText của mày hỗ trợ maxLines và overflow thì thêm:
                         // maxLines: 2,
                         // overflow: TextOverflow.ellipsis,
                       ),
                     ),
                   ],
                 ),

                 const SizedBox(height: TSizes.spaceBtwItems),

                 // Phần Trạng thái
                 Row(
                   children: [
                     const TProductTitleText(title: 'Trạng thái:', smallSize: true),
                     const SizedBox(width: TSizes.sm),
                     Expanded( // Để text trạng thái không làm tràn nếu dài
                       child: Text(
                         controller.variationStockStatus.value,
                         style: Theme.of(context).textTheme.titleMedium,
                         overflow: TextOverflow.ellipsis,
                         maxLines: 1,
                       ),
                     ),
                   ],
                 ),

                 const SizedBox(height: TSizes.spaceBtwItems),

                 // Mô tả variation
                 if (controller.selectedVariation.value.description != null &&
                     controller.selectedVariation.value.description!.isNotEmpty)
                   TProductTitleText(
                     title: controller.selectedVariation.value.description!,
                     smallSize: true,
                     maxLines: 4,
                     // overflow: TextOverflow.ellipsis,
                   ),
               ],
             ),
           ),





          const SizedBox(height: TSizes.spaceBtwItems),
          // Kiểm tra productAttributes có dữ liệu hay không
          if (product.productAttributes != null && product.productAttributes!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: product.productAttributes!
                  .map((attribute) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TSectionHeading(
                    title: 'Loại',
                    textColor: TColors.dark,
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Obx(
                        () => Wrap(
                      spacing: 10,
                      children: attribute.values.map((attributeValue) {
                        final isSelected =
                            controller.selectedAttributes[attribute.name] == attributeValue;
                        final available = controller
                            .getAttributesAvailabilityInVariation(
                          product.productVariations!,
                          attribute.name,
                        )
                            .contains(attributeValue);

                        return TChoiceChip(
                          text: attributeValue,
                          selected: isSelected,
                          onSelected: available
                              ? (selected) {
                            if (selected && available) {
                              controller.onAttributeSelected(
                                product,
                                attribute.name ?? '',
                                attributeValue,
                              );
                            }
                          }
                              : null,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}
