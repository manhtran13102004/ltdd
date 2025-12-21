import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho navigation (có thể không dùng trực tiếp ở đây)
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax (có thể không dùng trực tiếp ở đây)
import 'package:project/features/authentication/screens/signup/widgrts/signup_form.dart'; // Import widget form đăng ký
import 'package:project/utils/constants/colors.dart'; // Import màu sắc chuẩn (có thể không dùng trực tiếp ở đây)
import '../../../../common/widgets/login_signup/form_divider.dart'; // Import widget divider "hoặc đăng ký với"
import '../../../../common/widgets/login_signup/social_buttons.dart'; // Import widget nút đăng ký Google/Facebook
import '../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../../../utils/constants/text_strings.dart'; // Import các chuỗi text chuẩn
import '../../../../utils/helpers/helper_functions.dart'; // Import các hàm helper (có thể không dùng trực tiếp ở đây)

class SignupScreen extends StatelessWidget { // Màn hình đăng ký - StatelessWidget
  const SignupScreen({super.key}); // Constructor với key từ parent widget

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI


    return Scaffold( // Scaffold - widget cơ bản nhất của Material Design
      appBar: AppBar( // AppBar - thanh bar ở trên cùng màn hình
        title: const Text(TTexts.signupTitle), // Hiển thị tiêu đề "Tạo tài khoản" trên AppBar
      ),
      body: SingleChildScrollView( // SingleChildScrollView - cho phép cuộn nội dung khi bàn phím hiện lên
        child: Padding( // Padding - thêm khoảng cách xung quanh nội dung
          padding: const EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh
          child: Column( // Column - sắp xếp các widget theo chiều dọc
            children: [ // Danh sách các widget con
              // Title
              Text(TTexts.signupTitle, style: Theme.of(context).textTheme.headlineMedium), // Hiển thị tiêu đề "Tạo tài khoản" với style headlineMedium từ theme
              const SizedBox(height: TSizes.defaultSpace), // Khoảng cách giữa tiêu đề và form

              const TSignupForm(), // Widget form đăng ký (các trường nhập liệu)
              const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa form và divider

              TFormDivider(dividerText: TTexts.orSignInWith.capitalize!), // Divider với text "Hoặc đăng ký với" (capitalize để viết hoa chữ cái đầu)
              const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa divider và nút social

              const TSocialButtons(), // Widget chứa các nút đăng ký Google và Facebook
            ],
          ),
        ),
      ),
    );
  }
}


