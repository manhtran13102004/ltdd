import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp PageController
import 'package:get/get.dart'; // Import GetX - dùng cho state management và navigation

import '../screens/login/login.dart'; // Import màn hình đăng nhập

class OnBoardingController extends GetxController{ // Controller xử lý logic onboarding - kế thừa GetxController

  static OnBoardingController get instance => Get.find(); // Getter để lấy instance của OnBoardingController từ GetX dependency injection

  final pageController = PageController(); // PageController để quản lý PageView (điều khiển trang hiện tại)
  Rx<int> currentPageIndex = 0.obs; // Observable để lưu chỉ số trang hiện tại (mặc định = 0)

  void updatePageIndicator(index) => currentPageIndex.value = index ; // Hàm cập nhật chỉ số trang hiện tại khi user vuốt trang
  void doNavigationClick(index){ // Hàm xử lý khi user click vào dot navigation
    currentPageIndex.value = index; // Cập nhật chỉ số trang hiện tại
    pageController.jumpTo(index); // Nhảy đến trang được chỉ định (có thể sai, nên dùng jumpToPage)
  }

  void nextPage(){ // Hàm chuyển sang trang tiếp theo
    if(currentPageIndex.value == 2){ // Nếu đang ở trang cuối cùng (trang 2, index bắt đầu từ 0)
      Get.offAll(const LoginScreen()); // Điều hướng đến màn hình đăng nhập và xóa tất cả màn hình trước đó
    }else{ // Nếu chưa phải trang cuối
      int page = currentPageIndex.value + 1; // Tính trang tiếp theo
      pageController.jumpToPage(page); // Nhảy đến trang tiếp theo
    }

  }

  void skipPage() { // Hàm bỏ qua onboarding (nhảy đến trang cuối)
    currentPageIndex.value = 2; // Đặt chỉ số trang = 2 (trang cuối)
    pageController.jumpToPage(2); // Nhảy đến trang cuối cùng (trang 2)
  }

}
