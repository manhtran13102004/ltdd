import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp TextEditingController
import 'package:get/get.dart'; // Import GetX - dùng cho state management và navigation
import 'package:project/features/authentication/models/user_model.dart'; // Import UserModel
import 'package:project/features/authentication/screens/login/login.dart'; // Import màn hình login (có thể không dùng trực tiếp)
import 'package:project/repository/auth_repo/AuthenticationRepository.dart'; // Import AuthenticationRepository

import '../../../repository/user_repo/user_repo.dart'; // Import userRepo
import '../../../utils/navigation_menu.dart'; // Import navigation menu (có thể không dùng trực tiếp)

class LoginController extends GetxController { // Controller xử lý logic đăng nhập - kế thừa GetxController
  final email = TextEditingController(); // Controller để quản lý text input email
  final password = TextEditingController(); // Controller để quản lý text input password
  final userRepo0 = Get.put(userRepo()); // Khởi tạo và đăng ký userRepo vào GetX dependency injection
  var isLoading = false.obs; // Observable để quản lý trạng thái loading khi đăng nhập bằng email/password
  var isGoogleLoading = false.obs; // Observable để quản lý trạng thái loading khi đăng nhập bằng Google
  var isFacebookLoading = false.obs; // Observable để quản lý trạng thái loading khi đăng nhập bằng Facebook


  Future<void> login(String email, String password) async { // Hàm đăng nhập bằng email và password
    try { // Bắt đầu khối try-catch để xử lý lỗi
      isLoading.value = true; // Đặt trạng thái loading = true
      final auth = AuthenticationRepository.instance; // Lấy instance của AuthenticationRepository
      await auth.loginUserWithEmailAndPassword(email, password); // Gọi hàm đăng nhập từ repository
    } catch (e) { // Bắt lỗi nếu có
      Get.snackbar('Error', e.toString()); // Hiển thị snackbar thông báo lỗi
    } finally { // Khối finally luôn được thực thi
      isLoading.value = false; // Đặt trạng thái loading = false (dù thành công hay thất bại)
    }
  }

  Future<void> loginWithGoogle() async { // Hàm đăng nhập bằng Google
    try { // Bắt đầu khối try-catch để xử lý lỗi
      isGoogleLoading.value = true; // Đặt trạng thái loading Google = true
      final auth = AuthenticationRepository.instance; // Lấy instance của AuthenticationRepository
      await auth.signInWithGoogle(); // Gọi hàm đăng nhập Google từ repository
      UserModel userGoogle = UserModel( // Tạo UserModel từ thông tin Google
          id :'', // ID rỗng (sẽ được tạo tự động)
          firstName: '', // FirstName rỗng (có thể lấy từ Google profile)
          lastName: '', // LastName rỗng (có thể lấy từ Google profile)
          username: '', // Username rỗng
          gender: '', // Gender rỗng
          email: auth.getUserEmail, // Email từ Google account
          password: '123456789', // Password mặc định (không an toàn, nên thay đổi)
          phoneNo: '', // PhoneNo rỗng
        dateOfBirth: '', // DateOfBirth rỗng

      );

      var isLoginGoogle  =await userRepo0.getUserDetail(auth.getUserEmail); // Kiểm tra user đã tồn tại trong database chưa
      if(isLoginGoogle == null){ // Nếu user chưa tồn tại
        userRepo0.createUser(userGoogle); // Tạo user mới trong database
      }

      await  auth.setInitScreen(auth.firebaseUser); // Điều hướng đến màn hình phù hợp

    } catch (e) { // Bắt lỗi nếu có
      Get.snackbar('Error', e.toString()); // Hiển thị snackbar thông báo lỗi
    } finally { // Khối finally luôn được thực thi
      isGoogleLoading.value = false; // Đặt trạng thái loading Google = false (dù thành công hay thất bại)
    }
  }

  Future<void> loginWithFacebook() async { // Hàm đăng nhập bằng Facebook
    try { // Bắt đầu khối try-catch để xử lý lỗi
      isFacebookLoading.value = true; // Đặt trạng thái loading Facebook = true
      final auth = AuthenticationRepository.instance; // Lấy instance của AuthenticationRepository
      auth.signInWithFacebook(); // Gọi hàm đăng nhập Facebook từ repository (không await)
      auth.setInitScreen(auth.firebaseUser); // Điều hướng đến màn hình phù hợp
    } catch (e) { // Bắt lỗi nếu có
      Get.snackbar('Error', e.toString()); // Hiển thị snackbar thông báo lỗi
    } finally { // Khối finally luôn được thực thi
      isFacebookLoading.value = false; // Đặt trạng thái loading Facebook = false (dù thành công hay thất bại)
    }

  }
}
