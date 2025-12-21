import 'dart:async'; // Import thư viện async - dùng cho Timer

import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth (có thể không dùng trực tiếp)
import 'package:flutter/widgets.dart'; // Import Flutter widgets - cung cấp TextEditingController
import 'package:get/get.dart'; // Import GetX - dùng cho state management và navigation
import 'package:project/features/authentication/controllers.onboarding/login_controller.dart'; // Import LoginController
import 'package:project/features/authentication/models/user_model.dart'; // Import UserModel
import 'package:project/repository/user_repo/user_repo.dart'; // Import userRepo

import '../../../repository/auth_repo/AuthenticationRepository.dart'; // Import AuthenticationRepository
import '../screens/login/login.dart'; // Import màn hình đăng nhập

class PasswordResetEmail extends GetxController { // Controller xử lý đặt lại mật khẩu - kế thừa GetxController
  static  PasswordResetEmail get instance => Get.find(); // Getter để lấy instance của PasswordResetEmail từ GetX dependency injection
  final controllerLogin =Get.put(LoginController()); // Khởi tạo và đăng ký LoginController vào GetX dependency injection
  late Timer _timer; // Timer để kiểm tra trạng thái đặt lại mật khẩu định kỳ
  final auth =AuthenticationRepository.instance; // Lấy instance của AuthenticationRepository
  final email = TextEditingController(); // Controller để quản lý text input email
  Future<void> resendPasswordResetEmail() async { // Hàm gửi lại email đặt lại mật khẩu
    String emailToResend = email.text; // Lấy email từ TextEditingController
    try { // Bắt đầu khối try-catch để xử lý lỗi
      await auth.sendPasswordResetEmail(emailToResend); // Gọi hàm gửi email đặt lại mật khẩu từ repository
      Get.snackbar('Success', 'Password reset email resent. Please check your email.'); // Hiển thị snackbar thông báo thành công
    } catch (e) { // Bắt lỗi nếu có
      Get.snackbar('Error', e.toString()); // Hiển thị snackbar thông báo lỗi
    }
  }
  Future<void> sendPasswordResetEmail() async { // Hàm gửi email đặt lại mật khẩu
    String emailReset = email.text.trim(); // Lấy email từ TextEditingController và loại bỏ khoảng trắng đầu cuối
    try { // Bắt đầu khối try-catch để xử lý lỗi

      await auth.sendPasswordResetEmail(emailReset); // Gọi hàm gửi email đặt lại mật khẩu từ repository

      setTimerForAutoRedirect(); // Bắt đầu timer để tự động kiểm tra và điều hướng
    } catch (e) { // Bắt lỗi nếu có
      Get.snackbar('Error', e.toString()); // Hiển thị snackbar thông báo lỗi
    }
  }


  setTimerForAutoRedirect() { // Hàm thiết lập timer để tự động kiểm tra và điều hướng
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async { // Tạo timer chạy định kỳ mỗi 3 giây
      try { // Bắt đầu khối try-catch để xử lý lỗi
        UserModel user = await userRepo.instance.getUserDetail(email.text); // Lấy thông tin user từ database bằng email
        if (user != null) { // Nếu tìm thấy user
           String email =user.email; // Lấy email từ user
           String password =user.password; // Lấy password từ user (không an toàn, nên thay đổi)
          timer.cancel(); // Hủy timer
          await controllerLogin.login(email, password); // Đăng nhập với email và password
          Get.offAll(() => LoginScreen()); // Điều hướng đến màn hình đăng nhập và xóa tất cả màn hình trước đó
        }
      } catch (e) { // Bắt lỗi nếu có
        // Nếu có lỗi trong việc lấy thông tin người dùng, dừng timer
        timer.cancel(); // Hủy timer
        Get.snackbar('Error', 'Could not find user: ${e.toString()}'); // Hiển thị snackbar thông báo lỗi
      }
    });
  }

  manuallyCheckEmailVerificationStatus() {} // Hàm kiểm tra trạng thái xác thực email thủ công (chưa được implement)





}
