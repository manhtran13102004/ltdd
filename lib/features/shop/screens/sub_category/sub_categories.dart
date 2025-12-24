import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/features/shop/models/category_model.dart';
import 'package:project/utils/constants/sizes.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/layouts/grid_layout.dart'; // Thêm import TGridLayout từ home.dart
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../controllers/product/product_controller.dart';

class SubCategoriesScreen extends StatelessWidget {
  final CategoryModel category;

  const SubCategoriesScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // An toàn: dùng find nếu đã có, không thì put mới
    final productController = Get.isRegistered<ProductController>()
        ? Get.find<ProductController>()
        : Get.put(ProductController());
    // Nếu chưa có sản phẩm nào → load lại
    if (productController.allProducts.isEmpty) {
      productController.fetchAllProducts(); // ← THÊM DÒNG NÀY
    }


    // Lọc sản phẩm thuộc đúng danh mục này
    final products = productController.allProducts
        .where((p) => p.categoryId == category.id)
        .toList();

    return Scaffold(
      appBar: TAppBar(
        title: Text(category.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: TSizes.spaceBtwSections),

              TSectionHeading(
                title: category.name,
                onPressed: () {},
                textColor: Colors.black,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Giống hệt home.dart: nếu không có sản phẩm
              if (products.isEmpty)
                const Center(child: Text("Không có sản phẩm nào", style: TextStyle())),

              // Giống hệt home.dart: dùng TGridLayout để hiển thị sản phẩm
              TGridLayout(
                itemCount: products.length,
                itemBuilder: (_, index) {
                  return TProductCardVertical(product: products[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}