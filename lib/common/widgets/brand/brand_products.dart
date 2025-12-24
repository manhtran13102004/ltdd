// lib/common/widgets/brand/brand_products.dart

import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:project/common/widgets/appbar/appbar.dart';
import 'package:project/common/widgets/brand/brandcard.dart';
import 'package:project/common/widgets/layouts/grid_layout.dart';
import 'package:project/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:project/features/shop/controllers/product/product_controller.dart';
import 'package:project/features/shop/models/brand_model.dart';
import 'package:project/utils/constants/colors.dart';
import 'package:project/utils/constants/sizes.dart';

class BrandProducts extends StatelessWidget {
  final BrandModel brand;

  const BrandProducts({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>(); // Giống HomeScreen

    return Scaffold(
      appBar: TAppBar(title: Text(brand.name), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TBrandCard(brand: brand),
              const SizedBox(height: TSizes.spaceBtwSections),

              // GIỐNG HỆT PHẦN SẢN PHẨM BÁN CHẠY Ở HOME
              Obx(() {
                if (controller.allProducts.isEmpty) {
                  return const Center(
                    child: Text(
                      "Đang tải sản phẩm...",
                      style: TextStyle(color: TColors.primary),
                    ),
                  );
                }

                return TGridLayout(
                  itemCount: controller.allProducts.length,
                  itemBuilder: (_, index) {
                    return TProductCardVertical(
                      product: controller.allProducts[index],
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}