import 'package:flutter/cupertino.dart'; // Import Cupertino icons (icon clear)
import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho navigation
import 'package:get/get_core/src/get_main.dart'; // Import GetX core (có thể không cần thiết)
import 'package:project/features/authentication/controllers.onboarding/password_reset_email.dart'; // Import controller xử lý gửi email đặt lại mật khẩu
import 'package:project/features/authentication/screens/login/login.dart'; // Import màn hình đăng nhập

import '../../../../utils/constants/image_strings.dart'; // Import đường dẫn hình ảnh chuẩn
import '../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../../../utils/constants/text_strings.dart'; // Import các chuỗi text chuẩn
import '../../../../utils/helpers/helper_functions.dart'; // Import các hàm helper
import '../../controllers.onboarding/signup_controller.dart'; // Import signup controller (có thể không dùng trực tiếp)
class ResetPassword extends StatelessWidget { // Màn hình xác nhận đặt lại mật khẩu - StatelessWidget
  const ResetPassword({super.key}); // Constructor với key từ parent widget
  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    final controller =Get.put(PasswordResetEmail()); // Khởi tạo và đăng ký PasswordResetEmail controller vào GetX dependency injection
    return Scaffold( // Scaffold - widget cơ bản nhất của Material Design
      appBar: AppBar( // AppBar - thanh bar ở trên cùng màn hình
        automaticallyImplyLeading: false, // Tắt nút back mặc định (không hiển thị nút back tự động)
        actions: [ // Danh sách các action button trên AppBar
          IconButton( // Nút icon
              onPressed: () => Get.back(), // Khi click, quay lại màn hình trước đó
              icon: const Icon(CupertinoIcons.clear), // Icon dấu X để đóng
          ),
        ],
      ),
      body:  SingleChildScrollView( // SingleChildScrollView - cho phép cuộn nội dung
        child: Padding( // Padding - thêm khoảng cách xung quanh nội dung
            padding: const EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh
            child: Column( // Column - sắp xếp các widget theo chiều dọc
              children: [ // Danh sách các widget con
                Image( // Widget hiển thị hình ảnh minh họa email
                  image:  const AssetImage(TImages.deliveredEmailIllustration), // Load hình ảnh từ assets
                  width: THelperFunctions.screenWidth()*0.6, // Chiều rộng = 60% chiều rộng màn hình
                ),
                const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa hình ảnh và tiêu đề

                Text(TTexts.changeYourPasswordTitle, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,), // Hiển thị tiêu đề "Đổi mật khẩu của bạn!" với style headlineMedium, căn giữa
                const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách giữa tiêu đề và phụ đề
                Text(TTexts.changeYourPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,), // Hiển thị phụ đề hướng dẫn với style labelMedium, căn giữa
                const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa phụ đề và nút

                SizedBox( // SizedBox để giới hạn kích thước
                  width: double.infinity, // Chiều rộng bằng toàn bộ màn hình
                  child: ElevatedButton( // Nút "Xong" (nút chính, có màu nền)
                    onPressed: () { // Khi click nút
                      Get.offAll(()=> const LoginScreen()); // Navigate đến màn hình đăng nhập và xóa tất cả màn hình trước đó khỏi stack
                    },
                    child: const Text(TTexts.done), // Text hiển thị "Xong"
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách giữa nút "Xong" và nút "Gửi lại email"
                SizedBox( // SizedBox để giới hạn kích thước
                  width: double.infinity, // Chiều rộng bằng toàn bộ màn hình
                  child: TextButton( // Nút "Gửi lại email" (nút phụ, chỉ có text)
                    onPressed: () { // Khi click nút
                      controller.sendPasswordResetEmail(); // Gọi hàm sendPasswordResetEmail từ controller để gửi lại email đặt lại mật khẩu
                    },
                    child: const Text(TTexts.resendEmail), // Text hiển thị "Gửi lại email"
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
