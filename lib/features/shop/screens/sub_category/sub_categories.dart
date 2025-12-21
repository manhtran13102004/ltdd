import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:project/utils/constants/image_strings.dart'; // Import đường dẫn hình ảnh chuẩn

import '../../../../common/widgets/appbar/appbar.dart'; // Import widget AppBar chung
import '../../../../common/widgets/images/t_rounded_image.dart'; // Import widget hình ảnh bo góc
import '../../../../common/widgets/products/product_cards/product_card_horizontal.dart'; // Import widget card sản phẩm ngang
import '../../../../common/widgets/texts/section_heading.dart'; // Import widget tiêu đề section
import '../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn

class SubCategoriesScreen extends StatelessWidget { // Màn hình danh mục con - StatelessWidget
  const SubCategoriesScreen({super.key}); // Constructor với key từ parent widget

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    return Scaffold( // Scaffold - widget cơ bản nhất của Material Design
      appBar: TAppBar(title: Text('Danh Mục'),showBackArrow: true, ), // AppBar với nút back và tiêu đề "Danh Mục"
      body: SingleChildScrollView( // SingleChildScrollView - cho phép cuộn nội dung
        child: Padding( // Padding xung quanh nội dung
          padding: const EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh
          child: Column( // Column - sắp xếp các widget theo chiều dọc
            children: [ // Danh sách các widget con
              /* const TRoundedImage(width: double.infinity,image: TImages.promoBanner2,applyImageRadius: true,), */ // Comment code - banner hình ảnh
              const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa banner và section

             Column( // Column chứa section danh mục
               children: [ // Danh sách các widget con
                 TSectionHeading(title: 'Danh mục 1',onPressed: (){}, textColor: Colors.black,), // Tiêu đề section "Danh mục 1" với màu chữ đen
                 const SizedBox(height: TSizes.spaceBtwSections  ), // Khoảng cách giữa tiêu đề và danh sách sản phẩm


                 SizedBox( // SizedBox để giới hạn chiều cao
                   height: 120, // Chiều cao 120 pixels
                   child: Align( // Căn chỉnh danh sách sản phẩm

                     child: ListView.separated( // ListView với separator (khoảng cách giữa các item)
                       itemCount: 4, // Số lượng sản phẩm (hardcode = 4)
                       scrollDirection: Axis.horizontal, // Scroll theo chiều ngang
                       separatorBuilder: (context, index) => const SizedBox(width: TSizes.spaceBtwItems * 3), // Khoảng cách giữa các item = spaceBtwItems * 3
                       itemBuilder: (context, index) => const TProductCardHorizontal(), // Builder function để tạo ProductCardHorizontal cho mỗi item
                     ),
                   ),
                 ),



               ],
             )
            ],
          ),
        ),
      ),

    );
  }
}
