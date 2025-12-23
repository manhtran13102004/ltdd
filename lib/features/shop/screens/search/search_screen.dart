import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project/utils/constants/sizes.dart';

import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../controllers/product/product_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Tìm kiếm sản phẩm...',
            border: InputBorder.none,
            prefixIcon: Icon(Iconsax.search_normal),
          ),
          onChanged: (value) {
            // Tự động trigger search realtime
            productController.searchQuery.value = value.toLowerCase().trim();
          },
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final query = productController.searchQuery.value;

        // Nếu chưa nhập gì
        if (query.isEmpty) {
          return const Center(
            child: Text(
              'Nhập tên sản phẩm để tìm kiếm',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        // Filter sản phẩm theo tên gần đúng (không phân biệt hoa thường)
        final searchResults = productController.allProducts.where((product) {
          return product.title.toLowerCase().contains(query);
        }).toList();

        // Nếu không tìm thấy
        if (searchResults.isEmpty) {
          return const Center(
            child: Text(
              'Không tìm thấy sản phẩm nào',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        // Hiển thị kết quả giống hệt trang chủ
        return Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: TGridLayout(
            itemCount: searchResults.length,
            itemBuilder: (_, index) {
              return TProductCardVertical(product: searchResults[index]);
            },
          ),
        );
      }),
    );
  }
}