import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho state management
import 'package:get/get_core/src/get_main.dart'; // Import GetX core (có thể không cần thiết)
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax (có thể không dùng trực tiếp ở đây)
import 'package:project/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart'; // Import widget hiển thị dots navigation
import 'package:project/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart'; // Import widget nút "Tiếp theo"
import 'package:project/features/authentication/screens/onboarding/widgets/onboarding_page.dart'; // Import widget hiển thị một trang onboarding
import 'package:project/features/authentication/screens/onboarding/widgets/onboarding_skip.dart'; // Import widget nút "Bỏ qua"
import 'package:project/utils/constants/colors.dart'; // Import màu sắc chuẩn (có thể không dùng trực tiếp ở đây)
import 'package:project/utils/constants/image_strings.dart'; // Import đường dẫn hình ảnh chuẩn
import 'package:project/utils/device/device_utility.dart'; // Import utility để lấy kích thước thiết bị
import 'package:project/utils/helpers/helper_functions.dart'; // Import các hàm helper
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Import thư viện hiển thị page indicator mượt mà (có thể không dùng trực tiếp ở đây)

import '../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn (có thể không dùng trực tiếp ở đây)
import '../../../../utils/constants/text_strings.dart'; // Import các chuỗi text chuẩn
import '../../controllers.onboarding/onboarding_controller.dart'; // Import controller xử lý logic onboarding

class OnBoardingScreen extends StatelessWidget { // Màn hình onboarding - StatelessWidget
  const OnBoardingScreen({super.key}); // Constructor với key từ parent widget

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    final controller = Get.put(OnBoardingController()); // Khởi tạo và đăng ký OnBoardingController vào GetX dependency injection
    return Scaffold( // Scaffold - widget cơ bản nhất của Material Design
      body: Stack( // Stack - xếp chồng các widget lên nhau (PageView ở dưới, các button ở trên)
        children: [ // Danh sách các widget con

          PageView( // PageView - widget cho phép vuốt qua lại giữa các trang
             controller: controller.pageController, // Gán PageController từ controller để quản lý trang hiện tại
             onPageChanged: controller.updatePageIndicator, // Callback khi chuyển trang - cập nhật indicator
             children: const [ // Danh sách các trang onboarding
              OnBoardingPage( // Trang onboarding thứ nhất
                image:TImages.onBoardingImage1, // Hình ảnh của trang đầu tiên
                title:TTexts.onBoardingTitle1, // Tiêu đề của trang đầu tiên
                subTitle: TTexts.onBoardingSubTitle1, // Phụ đề của trang đầu tiên
              ),
               OnBoardingPage( // Trang onboarding thứ hai
                 image:TImages.onBoardingImage2, // Hình ảnh của trang thứ hai
                 title:TTexts.onBoardingTitle2, // Tiêu đề của trang thứ hai
                 subTitle: TTexts.onBoardingSubTitle2, // Phụ đề của trang thứ hai
               ),
               OnBoardingPage( // Trang onboarding thứ ba
                 image:TImages.onBoardingImage1, // Hình ảnh của trang thứ ba (dùng lại hình ảnh trang đầu)
                 title:TTexts.onBoardingTitle3, // Tiêu đề của trang thứ ba
                 subTitle: TTexts.onBoardingSubTitle3, // Phụ đề của trang thứ ba
               ),
      ],
    ),

          const OnBoardingSkip(), // Widget nút "Bỏ qua" - được đặt ở vị trí trên cùng bên phải

          const OnBoardingDotNavigation(), // Widget hiển thị dots navigation - được đặt ở giữa dưới cùng

          const OnBoardingNextButton(), // Widget nút "Tiếp theo" - được đặt ở góc dưới bên phải

          ],
      ),
    );
  }
}






