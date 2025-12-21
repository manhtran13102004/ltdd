import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho state management và snackbar
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax
import 'package:project/features/authentication/controllers.onboarding/signup_controller.dart'; // Import controller xử lý logic đăng ký
import 'package:project/features/authentication/models/user_model.dart'; // Import model UserModel
import 'package:project/features/authentication/screens/signup/widgrts/term_condition_textbox.dart'; // Import widget checkbox điều khoản
import '../../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../../../../utils/constants/text_strings.dart'; // Import các chuỗi text chuẩn

class TSignupForm extends StatelessWidget { // Widget form đăng ký - StatelessWidget
  const TSignupForm({ // Constructor
    super.key, // Key từ parent widget
  });

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    final controller = Get.put(SignupController()); // Khởi tạo và đăng ký SignupController vào GetX dependency injection
    final formKey = GlobalKey<FormState>(); // Key để quản lý form state (validate form)
    final showPassword = false.obs; // Observable để quản lý việc hiển thị/ẩn mật khẩu (false = ẩn)
    return Form( // Widget Form - quản lý form và validation
        key: formKey, // Gán key để có thể validate form
        child: Column( // Column - sắp xếp các widget theo chiều dọc
          children: [ // Danh sách các widget con
            Row( // Row - sắp xếp firstName và lastName cạnh nhau
              children: [ // Danh sách các widget con
                Expanded( // Expanded - cho phép widget con chiếm không gian còn lại
                  child: TextFormField( // TextField cho họ (firstName)
                    controller: controller.firstName, // Gán controller để quản lý text input
                    validator: (String? value) { // Hàm validate: kiểm tra dữ liệu nhập vào
                      return (value == null || value.isEmpty) // Nếu giá trị null hoặc rỗng
                          ? 'Please enter your first name.' // Trả về thông báo lỗi
                          : null; // Nếu hợp lệ thì trả về null
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction, // Tự động validate khi user tương tác
                    decoration: const InputDecoration( // Định nghĩa giao diện của TextField
                      labelText: TTexts.firstName, // Label hiển thị "Họ"
                      prefixIcon: Icon(Iconsax.user), // Icon ở đầu TextField (icon người dùng)
                      errorStyle: TextStyle( // Style cho thông báo lỗi
                        color: Colors.red, // Màu đỏ
                        fontSize: 12, // Kích thước chữ 12
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwInputFields), // Khoảng cách giữa firstName và lastName
                Expanded( // Expanded - cho phép widget con chiếm không gian còn lại
                  child: TextFormField( // TextField cho tên (lastName)
                    controller: controller.lastName, // Gán controller để quản lý text input
                    autovalidateMode: AutovalidateMode.onUserInteraction, // Tự động validate khi user tương tác
                    decoration: const InputDecoration( // Định nghĩa giao diện của TextField
                      labelText: TTexts.lastName, // Label hiển thị "Tên"
                      prefixIcon: Icon(Iconsax.user), // Icon ở đầu TextField (icon người dùng)
                      errorStyle: TextStyle( // Style cho thông báo lỗi
                        color: Colors.red, // Màu đỏ
                        fontSize: 12, // Kích thước chữ 12
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa row firstName/lastName và username
            TextFormField( // TextField cho tên đăng nhập (username)
              controller: controller.username, // Gán controller để quản lý text input
              validator: (value) { // Hàm validate: kiểm tra dữ liệu nhập vào
                if (value == null || value.isEmpty) { // Nếu giá trị null hoặc rỗng
                  return 'Please enter user name.'; // Trả về thông báo lỗi
                }

                return null; // Nếu hợp lệ thì trả về null
              },
              autovalidateMode: AutovalidateMode.onUserInteraction, // Tự động validate khi user tương tác
              expands: false, // Không cho phép mở rộng (single line)
              decoration: const InputDecoration( // Định nghĩa giao diện của TextField
                labelText: TTexts.username, // Label hiển thị "Tên đăng nhập"
                prefixIcon: Icon(Iconsax.user_edit), // Icon ở đầu TextField (icon chỉnh sửa người dùng)
                errorStyle: TextStyle( // Style cho thông báo lỗi
                  color: Colors.red, // Màu đỏ
                  fontSize: 12, // Kích thước chữ 12
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa username và email
            TextFormField( // TextField cho email
              controller: controller.email, // Gán controller để quản lý text input
              expands: false, // Không cho phép mở rộng (single line)
              validator: (value) { // Hàm validate: kiểm tra dữ liệu nhập vào
                if (value == null || value.isEmpty) { // Nếu giá trị null hoặc rỗng
                  return 'Please enter your email'; // Trả về thông báo lỗi
                }
                final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+'); // Regex pattern để kiểm tra định dạng email
                if (!emailRegex.hasMatch(value)) { // Nếu email không khớp với pattern
                  return 'Email is not valid.'; // Trả về thông báo lỗi
                }
                return null; // Nếu hợp lệ thì trả về null
              },
              autovalidateMode: AutovalidateMode.onUserInteraction, // Tự động validate khi user tương tác
              decoration: const InputDecoration( // Định nghĩa giao diện của TextField
                labelText: TTexts.email, // Label hiển thị "E-Mail"
                prefixIcon: Icon(Iconsax.direct), // Icon ở đầu TextField (icon email)
                errorStyle: TextStyle( // Style cho thông báo lỗi
                  color: Colors.red, // Màu đỏ
                  fontSize: 12, // Kích thước chữ 12
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa email và phone
            TextFormField( // TextField cho số điện thoại
              controller: controller.phoneNo, // Gán controller để quản lý text input
              expands: false, // Không cho phép mở rộng (single line)
              validator: (value) { // Hàm validate: kiểm tra dữ liệu nhập vào
                if (value == null || value.isEmpty) { // Nếu giá trị null hoặc rỗng
                  return 'Please enter your phone.'; // Trả về thông báo lỗi
                }
                final phoneRegex = RegExp(r'^\+84\d{9,10}$'); // Regex pattern để kiểm tra định dạng số điện thoại Việt Nam (+84 + 9-10 chữ số)
                if (!phoneRegex.hasMatch(value)) { // Nếu số điện thoại không khớp với pattern
                  return 'Phone is not valid.'; // Trả về thông báo lỗi
                }
                return null; // Nếu hợp lệ thì trả về null
              },
              autovalidateMode: AutovalidateMode.onUserInteraction, // Tự động validate khi user tương tác
              decoration: const InputDecoration( // Định nghĩa giao diện của TextField
                labelText: TTexts.phoneNo, // Label hiển thị "Số điện thoại"
                prefixIcon: Icon(Iconsax.call), // Icon ở đầu TextField (icon điện thoại)
                errorStyle: TextStyle( // Style cho thông báo lỗi
                  color: Colors.red, // Màu đỏ
                  fontSize: 12, // Kích thước chữ 12
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa phone và password
            Obx(() => TextFormField( // TextField cho mật khẩu - Obx để tự động rebuild khi showPassword thay đổi
                  controller: controller.password, // Gán controller để quản lý text input
                  validator: (value) { // Hàm validate: kiểm tra dữ liệu nhập vào
                    if (value == null || value.isEmpty) { // Nếu giá trị null hoặc rỗng
                      return 'Please enter your password'; // Trả về thông báo lỗi
                    }
                    if (value.length <= 6) { // Nếu mật khẩu có ít hơn hoặc bằng 6 ký tự
                      return 'Your password must be more than 6 characters.'; // Trả về thông báo lỗi
                    }
                    return null; // Nếu hợp lệ thì trả về null
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction, // Tự động validate khi user tương tác
                  obscureText: showPassword.value, // Ẩn/hiện password: nếu showPassword = true thì obscureText = true (ẩn)
                  decoration: InputDecoration( // Định nghĩa giao diện của TextField
                    labelText: TTexts.password, // Label hiển thị "Password"
                    prefixIcon: const Icon(Iconsax.password_check), // Icon ở đầu TextField (icon khóa)
                    suffixIcon: IconButton( // Icon ở cuối TextField (icon mắt)
                        onPressed: () { // Khi click vào icon
                          showPassword.value = !showPassword.value; // Đảo ngược giá trị showPassword (ẩn/hiện password)
                        },
                        icon: Icon(showPassword.value // Hiển thị icon mắt đóng nếu showPassword = true, icon mắt mở nếu false
                            ? Iconsax.eye_slash // Icon mắt đóng (ẩn password)
                            : Iconsax.eye)), // Icon mắt mở (hiện password)
                    errorStyle: const TextStyle( // Style cho thông báo lỗi
                      color: Colors.red, // Màu đỏ
                      fontSize: 12, // Kích thước chữ 12
                    ),
                  ),
                )),
            const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa password và checkbox điều khoản
            const TTermAndConditionTextBox(), // Widget checkbox đồng ý điều khoản
            const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa checkbox và nút đăng ký
            SizedBox( // SizedBox để giới hạn kích thước
              width: double.infinity, // Chiều rộng bằng toàn bộ màn hình
              child: ElevatedButton( // Nút "Tạo tài khoản" (nút chính, có màu nền)
                  onPressed: () { // Khi click nút đăng ký
                    if (formKey.currentState!.validate() && // Nếu form hợp lệ (tất cả các field đều pass validation)
                        controller.agree.value) { // VÀ checkbox đồng ý điều khoản được tích
                      final userModel = UserModel( // Tạo object UserModel từ dữ liệu form
                          id : '', // ID rỗng (sẽ được tạo tự động khi lưu vào database)
                          gender: '', // Giới tính rỗng (có thể thêm sau)
                          dateOfBirth: '', // Ngày sinh rỗng (có thể thêm sau)
                          firstName: controller.firstName.text.trim(), // Lấy họ và loại bỏ khoảng trắng đầu cuối
                          lastName: controller.lastName.text.trim(), // Lấy tên và loại bỏ khoảng trắng đầu cuối
                          username: controller.username.text.trim(), // Lấy tên đăng nhập và loại bỏ khoảng trắng đầu cuối
                          email: controller.email.text.trim(), // Lấy email và loại bỏ khoảng trắng đầu cuối
                          password: controller.password.text.trim(), // Lấy mật khẩu và loại bỏ khoảng trắng đầu cuối
                          phoneNo: controller.phoneNo.text.trim()); // Lấy số điện thoại và loại bỏ khoảng trắng đầu cuối
                      SignupController.instance.createUser(userModel); // Gọi hàm createUser từ controller để tạo tài khoản
                    } else { // Nếu form không hợp lệ hoặc chưa đồng ý điều khoản
                      Get.snackbar('Warning', 'You must agree to continue.'); // Hiển thị snackbar cảnh báo
                    }
                  },
                  child: const Text( // Text hiển thị trên nút
                    TTexts.createAccount, // "Tạo tài khoản"
                  )),
            ),
          ],
        ));
  }
}
