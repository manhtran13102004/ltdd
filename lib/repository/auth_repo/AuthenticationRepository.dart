import 'dart:async'; // Import thư viện async - dùng cho Future và Stream
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart'; // Import thư viện đăng nhập Facebook
import 'package:google_sign_in/google_sign_in.dart'; // Import thư viện đăng nhập Google
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Authentication
import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:flutter_native_splash/flutter_native_splash.dart'; // Import thư viện splash screen
import 'package:get/get.dart'; // Import GetX - dùng cho navigation, snackbar và state management
import 'package:project/features/authentication/screens/login/login.dart'; // Import màn hình đăng nhập
import 'package:project/features/authentication/screens/onboarding/onboarding.dart'; // Import màn hình onboarding
import 'package:project/features/authentication/screens/signup/verify_email.dart'; // Import màn hình xác thực email

import '../../utils/navigation_menu.dart'; // Import màn hình navigation menu
import '../exception/SignupWithEmailAndPasswordFailure.dart'; // Import exception class cho lỗi đăng ký

class AuthenticationRepository extends GetxController { // Repository xử lý authentication - kế thừa GetxController
  static AuthenticationRepository get instance => Get.find(); // Getter để lấy instance của AuthenticationRepository từ GetX dependency injection

  final _auth = FirebaseAuth.instance; // Lấy instance của FirebaseAuth
  late final Rx<User?> _firebaseUser; // Observable để lưu thông tin user hiện tại (late vì sẽ được khởi tạo trong onReady)

  User? get firebaseUser => _firebaseUser.value; // Getter để lấy user hiện tại từ observable

  String get getUserId => firebaseUser?.uid ?? ''; // Getter để lấy ID của user (nếu null thì trả về chuỗi rỗng)

  String get getUserEmail => firebaseUser?.email ?? ''; // Getter để lấy email của user (nếu null thì trả về chuỗi rỗng)
  bool isLogin = true; // Biến flag để đánh dấu trạng thái đăng nhập (có thể không dùng)

  @override
  void onReady() { // Hàm được gọi khi controller đã sẵn sàng
    _firebaseUser = Rx<User?>(_auth.currentUser); // Khởi tạo observable với user hiện tại (nếu có)
    _firebaseUser.bindStream(_auth.userChanges()); // Bind stream userChanges() để tự động cập nhật khi user đăng nhập/đăng xuất
    FlutterNativeSplash.remove(); // Xóa splash screen sau khi đã khởi tạo xong
    setInitScreen(_firebaseUser.value); // Gọi hàm setInitScreen để điều hướng đến màn hình phù hợp
  }

  setInitScreen(User? user) { // Hàm điều hướng đến màn hình phù hợp dựa trên trạng thái user
    user == null // Nếu không có user (chưa đăng nhập)
        ? Get.offAll(() => const OnBoardingScreen()) // Điều hướng đến màn hình onboarding và xóa tất cả màn hình trước đó
        : firebaseUser!.emailVerified // Nếu có user, kiểm tra email đã được xác thực chưa
            ? Get.offAll(() => const NavigationMenu()) // Nếu đã xác thực email, điều hướng đến màn hình chính
            : Get.offAll(() => VerifyEmailScreen(email: getUserEmail)); // Nếu chưa xác thực email, điều hướng đến màn hình xác thực email
  }

  Future<void> signInWithGoogle() async { // Hàm đăng nhập bằng Google
    try { // Bắt đầu khối try-catch để xử lý lỗi
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn(); // Hiển thị dialog đăng nhập Google và lấy thông tin tài khoản

      if (googleUser == null) { // Nếu user hủy đăng nhập (không chọn tài khoản)
        Get.offAll(() => const LoginScreen()); // Điều hướng về màn hình đăng nhập
        return; // Thoát hàm
      }

      // Lấy thông tin xác thực từ yêu cầu
      final GoogleSignInAuthentication? googleAuth = // Lấy thông tin authentication từ Google account
          await googleUser.authentication; // Chờ lấy thông tin authentication

      // Tạo một chứng chỉ mới
      final credential = GoogleAuthProvider.credential( // Tạo credential từ Google authentication
        accessToken: googleAuth?.accessToken, // Access token từ Google
        idToken: googleAuth?.idToken, // ID token từ Google
      );

      // Đăng nhập vào Firebase
      await FirebaseAuth.instance.signInWithCredential(credential); // Đăng nhập vào Firebase bằng credential
      setInitScreen(firebaseUser); // Điều hướng sau khi đăng nhập thành công
    } catch (e) { // Bắt lỗi nếu có
      Get.snackbar('Error', "Failed to sign in with Google: ${e.toString()}"); // Hiển thị snackbar thông báo lỗi
    }
  }

  Future<UserCredential> signInWithFacebook() async { // Hàm đăng nhập bằng Facebook
    // Trigger the sign-in flow
    final LoginResult loginResult = // Kết quả đăng nhập Facebook
        await FacebookAuth.instance.login(permissions: ['email']); // Gọi API đăng nhập Facebook với quyền truy cập email

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = // Tạo credential từ Facebook access token
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString); // Tạo credential từ token string

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential); // Đăng nhập vào Firebase bằng credential và trả về UserCredential
  }

  Future<void> createUserWithEmailAndPassword( // Hàm tạo tài khoản mới bằng email và password
      String email, String password) async { // Nhận email và password làm tham số
    try { // Bắt đầu khối try-catch để xử lý lỗi
      await _auth.createUserWithEmailAndPassword( // Gọi API Firebase để tạo tài khoản mới
          email: email, password: password); // Truyền email và password
    } on FirebaseAuthException catch (e) { // Bắt lỗi FirebaseAuthException
      final ex = SignupWithEmailAndPasswordFailure.code(e.code); // Chuyển đổi mã lỗi Firebase thành exception tùy chỉnh
      throw ex; // Ném exception để xử lý ở nơi gọi hàm
    } catch (_) {} // Bắt các lỗi khác nhưng không xử lý
  }

  Future<void> sendPasswordResetEmail(String email) async { // Hàm gửi email đặt lại mật khẩu
    try { // Bắt đầu khối try-catch để xử lý lỗi
      await _auth.sendPasswordResetEmail( email: email); // Gửi email đặt lại mật khẩu đến địa chỉ email được chỉ định

    } on FirebaseException catch (e) { // Bắt lỗi FirebaseException
      Get.snackbar('Error', e.message ?? 'An unknown error occurred'); // Hiển thị snackbar thông báo lỗi (hoặc thông báo mặc định nếu không có message)
    }
  }

  Future<void> sendEmailVerification() async { // Hàm gửi email xác thực
    try { // Bắt đầu khối try-catch để xử lý lỗi
      await _auth.currentUser?.sendEmailVerification(); // Gửi email xác thực đến user hiện tại (nếu có)
    } on FirebaseAuthException catch (e) { // Bắt lỗi FirebaseAuthException
      throw e; // Ném lại exception để xử lý ở nơi gọi hàm
    } catch (_) {} // Bắt các lỗi khác nhưng không xử lý

    }
  Future<void> deleteAccount() async { // Hàm xóa tài khoản
    try { // Bắt đầu khối try-catch để xử lý lỗi
      User? user = FirebaseAuth.instance.currentUser; // Lấy user hiện tại

      if (user != null) { // Nếu có user
        await user.delete(); // Xóa tài khoản
        print("Tài khoản đã được xóa thành công."); // In thông báo thành công ra console
      } else { // Nếu không có user
        print("Không có người dùng nào được xác thực."); // In thông báo ra console
      }
    } on FirebaseAuthException catch (e) { // Bắt lỗi FirebaseAuthException
      print("Lỗi khi xóa tài khoản: $e"); // In thông báo lỗi ra console
    }
  }
  Future<void> loginUserWithEmailAndPassword( // Hàm đăng nhập bằng email và password
      String email, String password) async { // Nhận email và password làm tham số
    try { // Bắt đầu khối try-catch để xử lý lỗi
      await _auth.signInWithEmailAndPassword(email: email, password: password); // Gọi API Firebase để đăng nhập
      setInitScreen(firebaseUser); // Điều hướng đến màn hình phù hợp sau khi đăng nhập thành công
      Get.snackbar('Login Successful', 'You are now logged in'); // Hiển thị snackbar thông báo đăng nhập thành công
    } on FirebaseAuthException catch (e) { // Bắt lỗi FirebaseAuthException
      String errorMessage; // Khai báo biến để lưu thông báo lỗi
      switch (e.code) { // Kiểm tra mã lỗi
        case 'user-not-found': // Nếu không tìm thấy user
          errorMessage = 'No user found with this email.'; // Thông báo lỗi tương ứng
          break; // Thoát switch
        case 'wrong-password': // Nếu sai mật khẩu
          errorMessage = 'Incorrect password. Please try again.'; // Thông báo lỗi tương ứng
          break; // Thoát switch
        case 'invalid-email': // Nếu email không hợp lệ
          errorMessage = 'The email format is invalid.'; // Thông báo lỗi tương ứng
          break; // Thoát switch
        default: // Các trường hợp khác
          errorMessage = 'User or password is incorrect.'; // Thông báo lỗi mặc định
      }
      Get.snackbar('Login Failed', errorMessage, backgroundColor: Colors.red); // Hiển thị snackbar thông báo lỗi với nền đỏ
    } catch (e) { // Bắt các lỗi khác
      print('An unexpected error occurred: $e'); // In lỗi ra console
      Get.snackbar('Error', 'Something went wrong. Please try again later.', // Hiển thị snackbar thông báo lỗi chung
          backgroundColor: Colors.red); // Màu nền đỏ
    }
  }

  Future<void> logOut() async { // Hàm đăng xuất
    try { // Bắt đầu khối try-catch để xử lý lỗi
      await GoogleSignIn().signOut(); // Đăng xuất khỏi Google (nếu đã đăng nhập bằng Google)
      await FirebaseAuth.instance.signOut(); // Đăng xuất khỏi Firebase
    } on FirebaseAuthException catch (e) { // Bắt lỗi FirebaseAuthException
      Get.snackbar('Error logout', e.message as String); // Hiển thị snackbar thông báo lỗi
    }
  }
}
