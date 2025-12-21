import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth (có thể không dùng trực tiếp)
import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp TextEditingController
import 'package:get/get.dart'; // Import GetX - dùng cho state management và navigation
import 'package:project/features/authentication/models/user_model.dart'; // Import UserModel
import 'package:project/repository/auth_repo/AuthenticationRepository.dart'; // Import AuthenticationRepository
import 'package:project/repository/user_repo/user_repo.dart'; // Import userRepo

import '../screens/login/login.dart'; // Import màn hình đăng nhập

class ProfileController extends GetxController { // Controller xử lý logic profile - kế thừa GetxController
  static ProfileController get instance => Get.find(); // Getter để lấy instance của ProfileController từ GetX dependency injection
  final firstName = TextEditingController(); // Controller để quản lý text input firstName
  final lastName = TextEditingController(); // Controller để quản lý text input lastName
  final username = TextEditingController(); // Controller để quản lý text input username
  final phoneNo =TextEditingController(); // Controller để quản lý text input phoneNo
  final gender =TextEditingController(); // Controller để quản lý text input gender
  final dateOrBirth =TextEditingController(); // Controller để quản lý text input dateOfBirth (có typo: dateOrBirth thay vì dateOfBirth)

  final _auth= Get.put(AuthenticationRepository()); // Khởi tạo và đăng ký AuthenticationRepository vào GetX dependency injection
  final _userRepo = Get.put(userRepo()); // Khởi tạo và đăng ký userRepo vào GetX dependency injection

  Future<UserModel?> getUserData() async { // Hàm lấy thông tin user từ database
    final email = _auth.firebaseUser?.email; // Lấy email từ Firebase user hiện tại
    if (email != null) { // Nếu có email
      UserModel userData = await _userRepo.getUserDetail(email); // Lấy thông tin user từ database
      return userData; // Trả về userData
    } else { // Nếu không có email (chưa đăng nhập)
      Get.snackbar('Error', "Login to continue"); // Hiển thị snackbar thông báo lỗi
      return null; // Trả về null
    }
  }

  updateUserData(UserModel user) async { // Hàm cập nhật thông tin user
    await _userRepo.updateUser(user); // Cập nhật user trong database
  }

  logOut() async { // Hàm đăng xuất
    await _auth.logOut(); // Gọi hàm đăng xuất từ AuthenticationRepository
    Get.offAll(() => const LoginScreen()); // Điều hướng đến màn hình đăng nhập và xóa tất cả màn hình trước đó
  }
  deleteUser(UserModel user ) async { // Hàm xóa user
    await _auth.deleteAccount(); // Xóa tài khoản Firebase
    await _userRepo.deleteUser(user); // Xóa user khỏi database
    Get.offAll(const LoginScreen()); // Điều hướng đến màn hình đăng nhập và xóa tất cả màn hình trước đó
  }



}
