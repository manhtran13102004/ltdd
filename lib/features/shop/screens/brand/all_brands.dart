import 'package:flutter/cupertino.dart'; // Import Cupertino (có thể không dùng trực tiếp)
import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho navigation
import 'package:project/utils/constants/colors.dart'; // Import màu sắc chuẩn

import '../../../../common/widgets/appbar/appbar.dart'; // Import widget AppBar chung
import '../../../../common/widgets/brand/brand_products.dart'; // Import màn hình sản phẩm của thương hiệu
import '../../../../common/widgets/brand/brandcard.dart'; // Import widget card thương hiệu
import '../../../../common/widgets/layouts/grid_layout.dart'; // Import widget layout dạng grid
import '../../../../common/widgets/products/sortable/sortbale_products.dart'; // Import widget sản phẩm có thể sắp xếp (có thể không dùng trực tiếp)
import '../../../../common/widgets/texts/section_heading.dart'; // Import widget tiêu đề section
import '../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn

class AllBrandScreen extends StatelessWidget { // Màn hình tất cả thương hiệu - StatelessWidget
  const AllBrandScreen({super.key}); // Constructor với key từ parent widget

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    return Scaffold( // Scaffold - widget cơ bản nhất của Material Design
      appBar: const TAppBar( showBackArrow: true, title: Text('Brand'),), // AppBar với nút back và tiêu đề "Brand"
      body: SingleChildScrollView( // SingleChildScrollView - cho phép cuộn nội dung
        child: Padding( // Padding xung quanh nội dung
          padding: const EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh
          child: Column( // Column - sắp xếp các widget theo chiều dọc
            children: [ // Danh sách các widget con

              const TSectionHeading(title: 'Brand',textColor: TColors.black,showActionButton: false,), // Tiêu đề section "Brand" với màu chữ đen, không có nút action
              const SizedBox(height: TSizes.spaceBtwItems,), // Khoảng cách giữa tiêu đề và grid thương hiệu

              TGridLayout(itemCount: 10,mainAxisExtent: 80,itemBuilder: (context, index) => TBrandCard(showBorder: true, onTap: () => Get.to(() => const BrandProducts()) ,),) // Widget grid layout hiển thị 10 thương hiệu, mỗi item có chiều cao 80 pixels, khi click sẽ navigate đến màn hình BrandProducts

            ],
          ),


        ),
      ),


    );
  }
}
