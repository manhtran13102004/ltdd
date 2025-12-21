import 'dart:async'; // Import thư viện async - dùng cho Timer

import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:get/get.dart'; // Import GetX - dùng cho state management

import '../../../repository/auth_repo/AuthenticationRepository.dart'; // Import AuthenticationRepository

class mail_vertification_controller extends GetxController { // Controller xử lý xác thực email - kế thừa GetxController
  late Timer _timer; // Timer để kiểm tra trạng thái xác thực email định kỳ

  @override
  void onInit() { // Hàm được gọi khi controller được khởi tạo
    super.onInit(); // Gọi hàm onInit của class cha
    sendVertificationEmail(); // Gửi email xác thực ngay khi controller được khởi tạo
    setTimerForAutoRedirect(); // Bắt đầu timer để tự động kiểm tra và điều hướng
  }

  Future<void> sendVertificationEmail() async { // Hàm gửi email xác thực
    try { // Bắt đầu khối try-catch để xử lý lỗi
      await AuthenticationRepository.instance.sendEmailVerification(); // Gọi hàm gửi email xác thực từ repository
    } catch (e) { // Bắt lỗi nếu có (không xử lý, chỉ bắt lỗi)

    }
  }

  setTimerForAutoRedirect() { // Hàm thiết lập timer để tự động kiểm tra và điều hướng
    _timer=Timer.periodic(const Duration(seconds: 3), (timer){ // Tạo timer chạy định kỳ mỗi 3 giây
      FirebaseAuth.instance.currentUser?.reload(); // Reload thông tin user từ Firebase để cập nhật trạng thái emailVerified
final user =FirebaseAuth.instance.currentUser; // Lấy user hiện tại
if(user!.emailVerified){ // Nếu email đã được xác thực
  timer.cancel(); // Hủy timer
  AuthenticationRepository.instance.setInitScreen(user); // Điều hướng đến màn hình phù hợp
}


    });
  }

  manuallyCheckEmailVerificationStatus() {} // Hàm kiểm tra trạng thái xác thực email thủ công (chưa được implement)
}
