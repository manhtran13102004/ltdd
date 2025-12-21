import 'package:flutter/cupertino.dart'; // Import Cupertino icons (icon clear)
import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho navigation và snackbar
import 'package:project/features/authentication/controllers.onboarding/mail_vertification_controller.dart'; // Import controller xử lý xác thực email
import 'package:project/repository/auth_repo/AuthenticationRepository.dart'; // Import authentication repository (có thể không dùng trực tiếp)
import 'package:project/utils/navigation_menu.dart'; // Import màn hình navigation menu (có thể không dùng trực tiếp)
import '../../../../common/widgets/success_screen/success_screen.dart'; // Import màn hình thành công
import '../../../../utils/constants/image_strings.dart'; // Import đường dẫn hình ảnh chuẩn
import '../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../../../utils/constants/text_strings.dart'; // Import các chuỗi text chuẩn
import '../../../../utils/helpers/helper_functions.dart'; // Import các hàm helper
import '../login/login.dart'; // Import màn hình đăng nhập

class VerifyEmailScreen extends StatelessWidget { // Màn hình xác thực email - StatelessWidget
  final String email; // Biến lưu email cần xác thực

  const VerifyEmailScreen({super.key, required this.email}); // Constructor với email parameter bắt buộc

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    final controller = Get.put(mail_vertification_controller()); // Khởi tạo và đăng ký mail_vertification_controller vào GetX dependency injection
    return Scaffold( // Scaffold - widget cơ bản nhất của Material Design
      appBar: AppBar( // AppBar - thanh bar ở trên cùng màn hình
        actions: [ // Danh sách các action button trên AppBar
          IconButton( // Nút icon
            onPressed: () => Get.offAll(() => const LoginScreen()), // Khi click, quay về màn hình đăng nhập và xóa tất cả màn hình trước đó
            icon: const Icon(CupertinoIcons.clear), // Icon dấu X để đóng
          ),
        ],
      ),
      body: SingleChildScrollView( // SingleChildScrollView - cho phép cuộn nội dung
        child: Padding( // Padding - thêm khoảng cách xung quanh nội dung
          padding: const EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh
          child: Column( // Column - sắp xếp các widget theo chiều dọc
            children: [ // Danh sách các widget con
              // Title
              Image( // Widget hiển thị hình ảnh minh họa email
                image: const AssetImage(TImages.deliveredEmailIllustration), // Load hình ảnh từ assets
                width: THelperFunctions.screenWidth() * 0.6, // Chiều rộng = 60% chiều rộng màn hình
              ),
              const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa hình ảnh và text

              Text( // Widget hiển thị tiêu đề
                TTexts.confirmEmail, // Text "Xác nhận email của bạn!"
                style: Theme.of(context).textTheme.headlineMedium, // Style tiêu đề từ theme
                textAlign: TextAlign.center, // Căn giữa text
              ),
              const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách giữa tiêu đề và email
              Text( // Widget hiển thị email
                email, // Hiển thị email được truyền vào (dynamic)
                style: Theme.of(context).textTheme.labelLarge, // Style label lớn từ theme
                textAlign: TextAlign.center, // Căn giữa text
              ),
              const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách giữa email và phụ đề
              Text( // Widget hiển thị phụ đề
                TTexts.confirmEmailSubTitle, // Text hướng dẫn xác thực email
                style: Theme.of(context).textTheme.labelMedium, // Style label vừa từ theme
                textAlign: TextAlign.center, // Căn giữa text
              ),
              const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa phụ đề và nút

              // Button
              SizedBox( // SizedBox để giới hạn kích thước
                width: double.infinity, // Chiều rộng bằng toàn bộ màn hình
                child: ElevatedButton( // Nút "Tiếp tục" (nút chính, có màu nền)
                  onPressed: () => Get.to(() => SuccessScreen( // Khi click, navigate đến màn hình thành công
                    image: TImages.staticSuccessIllustration, // Hình ảnh minh họa thành công
                    title: TTexts.yourAccountCreatedTitle, // Tiêu đề "Tài khoản của bạn đã được tạo!"
                    subtitle: TTexts.yourAccountCreatedSubTitle, // Phụ đề hướng dẫn
                    onPressed: () => Get.to(() => const LoginScreen()), // Callback khi click nút trên màn hình thành công - chuyển đến màn hình đăng nhập
                  )),
                  child: const Text( // Text hiển thị trên nút
                    TTexts.tContinue, // "Tiếp tục"
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách giữa nút "Tiếp tục" và nút "Gửi lại email"
              SizedBox( // SizedBox để giới hạn kích thước
                width: double.infinity, // Chiều rộng bằng toàn bộ màn hình
                child: TextButton( // Nút "Gửi lại email" (nút phụ, chỉ có text)
                  onPressed: () { // Khi click nút
                    Get.snackbar('Email Sent', 'A new verification email has been sent.'); // Hiển thị snackbar thông báo đã gửi email

                  },
                  child: const Text( // Text hiển thị trên nút
                    TTexts.resendEmail, // "Gửi lại email"
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách cuối cùng
            ],
          ),
        ),
      ),
    );
  }
}
