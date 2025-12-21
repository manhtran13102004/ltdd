import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho navigation và snackbar
import 'package:get/get_core/src/get_main.dart'; // Import GetX core (có thể không cần thiết)
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax
import 'package:project/features/authentication/controllers.onboarding/password_reset_email.dart'; // Import controller xử lý gửi email đặt lại mật khẩu
import 'package:project/features/authentication/models/user_model.dart'; // Import model UserModel (có thể không dùng trực tiếp)
import 'package:project/features/authentication/screens/password_configuration/reset_password.dart'; // Import màn hình xác nhận đặt lại mật khẩu
import 'package:project/repository/user_repo/user_repo.dart'; // Import user repository (có thể không dùng trực tiếp)
import 'package:project/utils/constants/sizes.dart'; // Import kích thước chuẩn

import '../../../../utils/constants/text_strings.dart'; // Import các chuỗi text chuẩn

class ForgotPassword extends StatelessWidget { // Màn hình quên mật khẩu - StatelessWidget
  const ForgotPassword ({super.key}); // Constructor với key từ parent widget

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    final controller =Get.put(PasswordResetEmail()); // Khởi tạo và đăng ký PasswordResetEmail controller vào GetX dependency injection
    return Scaffold( // Scaffold - widget cơ bản nhất của Material Design
      appBar: AppBar(), // AppBar - thanh bar ở trên cùng màn hình (có nút back mặc định)
      body: Padding( // Padding - thêm khoảng cách xung quanh nội dung
          padding: const EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh
        child: Column( // Column - sắp xếp các widget theo chiều dọc
          crossAxisAlignment: CrossAxisAlignment.center, // Căn giữa các widget con theo chiều ngang
          children: [ // Danh sách các widget con
            Text(TTexts.forgetPassword, style: Theme.of(context).textTheme.headlineMedium,), // Hiển thị tiêu đề "Quên mật khẩu?" với style headlineMedium từ theme
            const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách giữa tiêu đề và phụ đề
            Text(TTexts.forgetPasswordSubTitle, style: Theme.of(context).textTheme.labelMedium), // Hiển thị phụ đề hướng dẫn với style labelMedium từ theme
            const SizedBox(height: TSizes.spaceBtwSections * 2), // Khoảng cách lớn giữa phụ đề và TextField (gấp đôi khoảng cách chuẩn)

           TextFormField( // TextField cho email
             controller: controller.email, // Gán controller để quản lý text input
             decoration: const InputDecoration( // Định nghĩa giao diện của TextField
               labelText: TTexts.email, // Label hiển thị "E-Mail"
               prefixIcon: Icon(Iconsax.direct), // Icon ở đầu TextField (icon email)
             ),
           ),

            const SizedBox(height: TSizes.spaceBtwSections ), // Khoảng cách giữa TextField và nút

            SizedBox( // SizedBox để giới hạn kích thước
              width: double.infinity, // Chiều rộng bằng toàn bộ màn hình
              child: ElevatedButton( // Nút "Gửi" (nút chính, có màu nền)
                  onPressed: () { // Khi click nút
                       var email =controller.email.text.trim(); // Lấy email từ TextField và loại bỏ khoảng trắng đầu cuối

                       if (email.isNotEmpty) { // Nếu email không rỗng
                         controller.sendPasswordResetEmail(); // Gọi hàm sendPasswordResetEmail từ controller để gửi email đặt lại mật khẩu
                         Get.off(() =>const ResetPassword()); // Navigate đến màn hình xác nhận đặt lại mật khẩu và xóa màn hình hiện tại khỏi stack
                       } else { // Nếu email rỗng
                         Get.snackbar('Error', 'Please enter a valid email'); // Hiển thị snackbar thông báo lỗi
                       }               } ,
                  child: const Text(TTexts.submit), // Text hiển thị "Gửi"
              ),
            ),
          ],
        ),
      ),
    );
  }
}
