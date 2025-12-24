import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax (có thể không dùng trực tiếp)

import '../../../../common/widgets/appbar/appbar.dart'; // Import widget AppBar chung
import '../../../../common/widgets/layouts/grid_layout.dart'; // Import widget layout dạng grid (có thể không dùng trực tiếp)
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart'; // Import widget card sản phẩm dọc (có thể không dùng trực tiếp)
import '../../../../common/widgets/products/sortable/sortable_products.dart'; // Import widget sản phẩm có thể sắp xếp
import '../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn

class AllProduct extends StatelessWidget { // Màn hình tất cả sản phẩm - StatelessWidget
  const AllProduct({super.key}); // Constructor với key từ parent widget

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    return Scaffold( // Scaffold - widget cơ bản nhất của Material Design

      appBar: TAppBar( showBackArrow: true, title: Text('Tất cả các sản phẩm', style: Theme.of(context).textTheme.headlineSmall,),), // AppBar với nút back và tiêu đề "Tất cả các sản phẩm"
      body: const SingleChildScrollView( // SingleChildScrollView - cho phép cuộn nội dung
        child: Padding( // Padding xung quanh nội dung
            padding: const EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh (có thể bỏ const trong EdgeInsets.all)
            child: TSortableProducts()), // Widget hiển thị sản phẩm có thể sắp xếp (theo giá, tên, mới nhất...)
      ),


    );
  }
}
