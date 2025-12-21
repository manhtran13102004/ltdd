import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản

import '../../../../../utils/constants/image_strings.dart'; // Import đường dẫn hình ảnh chuẩn
import '../../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../../../../utils/constants/text_strings.dart'; // Import các chuỗi text chuẩn
import '../../../../../utils/helpers/helper_functions.dart'; // Import các hàm helper
class TLoginHeader extends StatelessWidget { // Widget header của màn hình login - StatelessWidget vì không cần state
  const TLoginHeader({ // Constructor
    super.key, // Key từ parent widget
  });


  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    final  dark = THelperFunctions.isDarkMode(context); // Kiểm tra chế độ dark mode - nếu dark = true thì dùng logo sáng, ngược lại dùng logo tối
    return Column( // Column - sắp xếp các widget theo chiều dọc
      crossAxisAlignment: CrossAxisAlignment.start, // Căn các widget con về phía bên trái
      children: [ // Danh sách các widget con
        Image( // Widget hiển thị hình ảnh logo
          height: 150, // Chiều cao logo là 150 pixels
          image: AssetImage(dark ? TImages.lightAppLogo : TImages.darkAppLogo), // Chọn logo: nếu dark mode thì dùng logo sáng, ngược lại dùng logo tối
        ),
        Text(TTexts.loginTitle, style: Theme.of(context).textTheme.headlineMedium), // Hiển thị tiêu đề "Chào mừng trở lại" với style headlineMedium từ theme
        const SizedBox(height: TSizes.sm), // Khoảng cách nhỏ giữa tiêu đề và phụ đề
        Text(TTexts.loginSubTitle, style: Theme.of(context).textTheme.bodyMedium), // Hiển thị phụ đề "Khám phá các sản phẩm nông sản chất lượng" với style bodyMedium từ theme
      ],
    );
  }
}