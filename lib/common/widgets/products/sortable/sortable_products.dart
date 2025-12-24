import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/features/shop/controllers/product/product_controller.dart';
import 'package:project/utils/constants/sizes.dart';
import '../../layouts/grid_layout.dart';
import '../product_cards/product_card_vertical.dart';

class TSortableProducts extends StatelessWidget {
  final String? brandId; // Truyền brandId để filter

  const TSortableProducts({super.key, this.brandId});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();

    return Column(
      children: [
        // Dropdown sort (tạm để trống, sau này thêm sort thật)
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          items: ['Tên', 'Giá cao đến thấp', 'Giá thấp đến cao', 'Mới nhất', 'Phổ biến']
              .map((option) => DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
          onChanged: (value) {
            // Sau này implement sort ở đây
          },
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        // Grid sản phẩm với filter brandId – KHÔNG TẠO RxList tạm → không lỗi đỏ
        Obx(() {
          // Lấy list gốc
          final allProducts = productController.allProducts;

          // Filter ra List bình thường (an toàn với GetX)
          final filteredProducts = allProducts.where((p) {
            if (brandId == null || brandId!.isEmpty) return true;
            return p.brandId == brandId;
          }).toList();

          if (filteredProducts.isEmpty) {
            return const Center(
              child: Text('Không có sản phẩm nào thuộc chi nhánh này'),
            );
          }

          return TGridLayout(
            itemCount: filteredProducts.length,
            itemBuilder: (_, index) {
              return TProductCardVertical(product: filteredProducts[index]);
            },
          );
        }),
      ],
    );
  }
}