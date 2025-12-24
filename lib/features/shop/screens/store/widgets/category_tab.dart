// lib/features/shop/screens/store/widgets/category_tab.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/common/widgets/layouts/grid_layout.dart';
import 'package:project/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:project/common/widgets/texts/section_heading.dart';
import 'package:project/features/shop/controllers/product/product_controller.dart';
import 'package:project/features/shop/models/category_model.dart';
import 'package:project/utils/constants/colors.dart';
import 'package:project/utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductController>();

    // Nếu chưa load allProducts → load ngay (giống SubCategoriesScreen)
    if (controller.allProducts.isEmpty) {
      controller.fetchAllProducts();
    }

    return Obx(() {
      // Lọc sản phẩm theo category.id
      final categoryProducts = controller.allProducts
          .where((p) => p.categoryId == category.id)
          .toList();

      // Loading khi đang fetch
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // Không có sản phẩm
      if (categoryProducts.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Text(
              'Chưa có sản phẩm nào trong danh mục này',
              style: TextStyle(fontSize: 16, color: TColors.darkGrey),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      // Có sản phẩm → hiển thị grid giống hệt trang chủ và SubCategories
      return Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: TGridLayout(
          itemCount: categoryProducts.length,
          itemBuilder: (_, index) {
            return TProductCardVertical(product: categoryProducts[index]);
          },
        ),
      );
    });
  }
}