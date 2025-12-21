import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho state management và navigation
import 'package:get/get_core/src/get_main.dart'; // Import GetX core (có thể không cần thiết)
import 'package:get_storage/get_storage.dart'; // Import GetStorage - lưu trữ dữ liệu local
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax
import 'package:project/repository/user_repo/user_repo.dart'; // Import user repository (có thể không dùng)

import '../../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../../../../utils/constants/text_strings.dart'; // Import các chuỗi text chuẩn
import '../../../../../utils/navigation_menu.dart'; // Import màn hình navigation menu (có thể không dùng)
import '../../../controllers.onboarding/login_controller.dart'; // Import controller xử lý logic đăng nhập
import '../../password_configuration/forgot_password.dart'; // Import màn hình quên mật khẩu
import '../../signup/signup.dart'; // Import màn hình đăng ký

class TLoginForm extends StatelessWidget { // Widget form đăng nhập - StatelessWidget
  const TLoginForm({ // Constructor
    super.key, // Key từ parent widget
  });

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    final controller = Get.put(LoginController()); // Khởi tạo và đăng ký LoginController vào GetX dependency injection
    final _loginformKey = GlobalKey<FormState>(); // Key để quản lý form state (validate form)
    final loginController = Get.find<LoginController>(); // Lấy instance của LoginController đã được đăng ký
    final storage= GetStorage(); // Khởi tạo GetStorage để lưu/đọc dữ liệu local
    final showPassword =false.obs; // Observable để quản lý việc hiển thị/ẩn mật khẩu (false = ẩn)
    final remember =true.obs; // Observable để quản lý checkbox "Nhớ tôi" (true = đã tích)
    loginController.email.text = storage.read('email') ?? ''; // Đọc email đã lưu từ storage, nếu không có thì dùng chuỗi rỗng
    loginController.password.text = storage.read('password') ?? ''; // Đọc password đã lưu từ storage, nếu không có thì dùng chuỗi rỗng
    remember.value = storage.read('remember') ?? false; // Đọc trạng thái "nhớ tôi" từ storage, nếu không có thì false
    return Form( // Widget Form - quản lý form và validation
      key: _loginformKey, // Gán key để có thể validate form
      child: Column( // Column - sắp xếp các widget theo chiều dọc
        children: [ // Danh sách các widget con
          TextFormField( // TextField cho email
            controller: controller.email, // Gán controller để quản lý text input
            decoration: const InputDecoration( // Định nghĩa giao diện của TextField
              prefixIcon: Icon(Iconsax.direct_right), // Icon ở đầu TextField (icon email)
              labelText: TTexts.email, // Label hiển thị "E-Mail"
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields), // Khoảng cách giữa email field và password field
          Obx(()=>TextFormField( // TextField cho password - Obx để tự động rebuild khi showPassword thay đổi
            autovalidateMode: AutovalidateMode.onUserInteraction, // Tự động validate khi user tương tác
            obscureText: !showPassword.value, // Ẩn/hiện password: nếu showPassword = false thì obscureText = true (ẩn)
            controller: controller.password, // Gán controller để quản lý text input
            decoration: InputDecoration( // Định nghĩa giao diện của TextField
                prefixIcon: const Icon(Iconsax.password_check), // Icon ở đầu TextField (icon khóa)
                labelText: TTexts.password, // Label hiển thị "Password"
                suffixIcon: // Icon ở cuối TextField
                IconButton(onPressed: (){ // Khi click vào icon
                  showPassword.value=! showPassword.value; // Đảo ngược giá trị showPassword (ẩn/hiện password)
                }, icon: Icon(showPassword.value ? Iconsax.eye :Iconsax.eye_slash)) // Hiển thị icon mắt mở nếu showPassword = true, icon mắt đóng nếu false
            ),
          ),),
          const SizedBox(height: TSizes.spaceBtwInputFields / 2), // Khoảng cách nhỏ giữa password field và checkbox/button

          // Remember Me and Forgot Password
          Row( // Row - sắp xếp các widget theo chiều ngang
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Căn các widget con: checkbox bên trái, button bên phải
            children: [ // Danh sách các widget con
              Row( // Row chứa checkbox và text "Nhớ tôi"
                children: [ // Danh sách các widget con
                 Obx(()=> Checkbox(value: remember.value, onChanged: (value) { // Checkbox "Nhớ tôi" - Obx để tự động rebuild khi remember thay đổi
                   remember.value= !remember.value; // Đảo ngược giá trị remember khi click checkbox

                 }),),
                  const Text(TTexts.rememberMe), // Text hiển thị "Nhớ tôi"
                ],
              ),
              TextButton( // Button "Quên mật khẩu"
                  onPressed: () => Get.to(() => const ForgotPassword()), // Khi click, navigate đến màn hình quên mật khẩu
                  child: const Text(TTexts.forgetPassword)), // Text hiển thị "Quên mật khẩu?"
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách lớn giữa checkbox/button và nút đăng nhập

          // Buttons
          SizedBox( // SizedBox để giới hạn kích thước
            width: double.infinity, // Chiều rộng bằng toàn bộ màn hình
            child: ElevatedButton( // Nút đăng nhập (nút chính, có màu nền)
              onPressed: () // Khi click nút đăng nhập
                  {
                    if (remember.value) { // Nếu checkbox "Nhớ tôi" được tích
                      storage.write('email', loginController.email.text); // Lưu email vào storage
                      storage.write('password', loginController.password.text); // Lưu password vào storage
                      storage.write('rememberMe', true); // Lưu trạng thái "nhớ tôi" = true
                    } else { // Nếu checkbox "Nhớ tôi" không được tích
                      storage.remove('email'); // Xóa email khỏi storage
                      storage.remove('password'); // Xóa password khỏi storage
                      storage.write('rememberMe', false); // Lưu trạng thái "nhớ tôi" = false
                    }

                    String email = controller.email.text.trim(); // Lấy email từ TextField và loại bỏ khoảng trắng đầu cuối
                    String password = controller.password.text.trim(); // Lấy password từ TextField và loại bỏ khoảng trắng đầu cuối
                    print( controller.email.text.trim()); // In email ra console để debug
                    print( controller.password.text.trim()); // In password ra console để debug
                    loginController.login(email, password); // Gọi hàm login từ controller để xử lý đăng nhập
                  },
              child: const Text(TTexts.signIn), // Text hiển thị "Đăng nhập"
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields), // Khoảng cách giữa nút đăng nhập và nút tạo tài khoản
          SizedBox( // SizedBox để giới hạn kích thước
            width: double.infinity, // Chiều rộng bằng toàn bộ màn hình
            child: OutlinedButton( // Nút tạo tài khoản (nút phụ, chỉ có viền)
              onPressed: () => Get.to(() => const SignupScreen()), // Khi click, navigate đến màn hình đăng ký
              child: const Text(TTexts.createAccount), // Text hiển thị "Tạo tài khoản"
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields), // Khoảng cách cuối cùng
        ],
      ),
    );
  }
}
