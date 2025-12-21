import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp TextEditingController
import 'package:get/get.dart'; // Import GetX - dùng cho state management và navigation
import 'package:get/get_state_manager/src/simple/get_controllers.dart'; // Import GetX controllers (có thể không cần thiết)
import 'package:project/features/authentication/models/user_model.dart'; // Import UserModel
import 'package:project/features/authentication/screens/signup/verify_email.dart'; // Import màn hình xác thực email
import 'package:project/repository/auth_repo/AuthenticationRepository.dart'; // Import AuthenticationRepository
import 'package:project/repository/user_repo/user_repo.dart'; // Import userRepo



class SignupController extends GetxController { // Controller xử lý logic đăng ký - kế thừa GetxController
  static SignupController get instance => Get.find(); // Getter để lấy instance của SignupController từ GetX dependency injection

  final email = TextEditingController(); // Controller để quản lý text input email
  final firstName = TextEditingController(); // Controller để quản lý text input firstName
  final lastName = TextEditingController(); // Controller để quản lý text input lastName
  final username = TextEditingController(); // Controller để quản lý text input username
  final password = TextEditingController(); // Controller để quản lý text input password
  final phoneNo = TextEditingController(); // Controller để quản lý text input phoneNo
  final dateOfBirth = TextEditingController(); // Controller để quản lý text input dateOfBirth
  final agree =false.obs; // Observable để quản lý checkbox đồng ý điều khoản (mặc định = false)

  final userRepo0 = Get.put(userRepo()); // Khởi tạo và đăng ký userRepo vào GetX dependency injection
  Future<void> createUser(UserModel user) async { // Hàm tạo user mới

    await AuthenticationRepository.instance // Gọi hàm tạo tài khoản Firebase
        .createUserWithEmailAndPassword(user.email, user.password); // Tạo tài khoản Firebase với email và password
    await userRepo0.createUser(user); // Tạo user trong Firestore database
    Get.offAll(()=> VerifyEmailScreen(email: user.email)); // Điều hướng đến màn hình xác thực email và xóa tất cả màn hình trước đó


  }
}


