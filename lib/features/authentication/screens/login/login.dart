import 'package:flutter/material.dart'; // Import thư viện Flutter Material - cung cấp các widget cơ bản như Scaffold, Column, Text...
import 'package:get/get.dart'; // Import GetX - dùng cho navigation và state management
import 'package:get/get_common/get_reset.dart'; // Import GetX reset utilities (có thể không cần thiết)
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax - cung cấp các icon đẹp
import 'package:project/common/styles/spacing_styles.dart'; // Import spacing styles - định nghĩa padding/margin chuẩn
import 'package:project/features/authentication/screens/login/widgets/login_form.dart'; // Import widget form đăng nhập
import 'package:project/features/authentication/screens/login/widgets/login_header.dart'; // Import widget header (logo, title) của màn hình login
import '../../../../common/widgets/login_signup/form_divider.dart'; // Import widget divider "hoặc đăng nhập với"
import '../../../../common/widgets/login_signup/social_buttons.dart'; // Import widget nút đăng nhập Google/Facebook
import '../../../../utils/constants/colors.dart'; // Import màu sắc chuẩn của app
import '../../../../utils/constants/image_strings.dart'; // Import đường dẫn hình ảnh chuẩn
import '../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn (spacing, padding...)
import '../../../../utils/constants/text_strings.dart'; // Import các chuỗi text chuẩn
import '../../../../utils/helpers/helper_functions.dart'; // Import các hàm helper (kiểm tra dark mode...)

class LoginScreen extends StatelessWidget { // Định nghĩa màn hình đăng nhập - StatelessWidget vì không cần quản lý state
  const LoginScreen({super.key}); // Constructor với key từ parent widget

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI của màn hình
    final dark = THelperFunctions.isDarkMode(context); // Kiểm tra xem app đang ở chế độ dark mode hay không

    return Scaffold( // Scaffold - widget cơ bản nhất của Material Design, cung cấp cấu trúc màn hình
      body: SingleChildScrollView( // SingleChildScrollView - cho phép cuộn nội dung khi bàn phím hiện lên
        child: Padding( // Padding - thêm khoảng cách xung quanh nội dung
          padding: TSpacingStyle.paddingWithAppBarHeight, // Padding chuẩn có tính đến chiều cao AppBar
          child: Column( // Column - sắp xếp các widget theo chiều dọc
            children: [ // Danh sách các widget con
              // Logo and title
              const TLoginHeader(), // Widget hiển thị logo và tiêu đề "Chào mừng trở lại"
              const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa header và form
              // Login form
              const TLoginForm(), // Widget form đăng nhập (email, password, nút đăng nhập)
              const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa form và divider
              // Divider
              TFormDivider(dividerText: TTexts.orSignInWith.capitalize!), // Divider với text "Hoặc đăng nhập với" (capitalize để viết hoa chữ cái đầu)
              const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa divider và nút social
              const TSocialButtons(), // Widget chứa các nút đăng nhập Google và Facebook
            ],
          ),
        ),
      ),
    );
  }
}






