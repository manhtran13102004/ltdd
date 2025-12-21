import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản

import '../../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../../../../utils/helpers/helper_functions.dart'; // Import các hàm helper
class OnBoardingPage extends StatelessWidget { // Widget hiển thị một trang onboarding - StatelessWidget
  const OnBoardingPage({ // Constructor
    super.key, // Key từ parent widget
    required this.image, // Tham số bắt buộc: đường dẫn hình ảnh
    required this.title, // Tham số bắt buộc: tiêu đề
    required this.subTitle, // Tham số bắt buộc: phụ đề
  });

  final String image, title, subTitle; // Khai báo các biến final để lưu trữ dữ liệu

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    return Padding( // Padding - thêm khoảng cách xung quanh nội dung
      padding: const EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh
      child: Column( // Column - sắp xếp các widget theo chiều dọc
        mainAxisAlignment: MainAxisAlignment.center, // Căn giữa các widget con theo chiều dọc
        children: [ // Danh sách các widget con
          Image( // Widget hiển thị hình ảnh
            width: THelperFunctions.screenWidth() * 0.99, // Chiều rộng = 99% chiều rộng màn hình
            height: THelperFunctions.screenHeight() * 0.4, // Chiều cao = 40% chiều cao màn hình
            image: AssetImage(image), // Load hình ảnh từ assets với đường dẫn được truyền vào
          ),
          const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách giữa hình ảnh và tiêu đề
          Text( // Widget hiển thị tiêu đề
            title, // Nội dung tiêu đề
            style: Theme.of(context).textTheme.headlineMedium, // Style tiêu đề từ theme (kích thước lớn, đậm)
            textAlign: TextAlign.center, // Căn giữa text
          ),
          const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách giữa tiêu đề và phụ đề
          Text( // Widget hiển thị phụ đề
            subTitle, // Nội dung phụ đề
            style: Theme.of(context).textTheme.bodyMedium, // Style phụ đề từ theme (kích thước vừa, bình thường)
            textAlign: TextAlign.center, // Căn giữa text
          ),
        ],
      ),
    );
  }
}