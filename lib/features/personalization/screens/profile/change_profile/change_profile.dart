import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth (có thể không dùng trực tiếp)
import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho state management và navigation
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax
import 'package:project/features/authentication/controllers.onboarding/profile_controller.dart'; // Import ProfileController
import 'package:project/features/authentication/controllers.onboarding/signup_controller.dart'; // Import SignupController (có thể không dùng trực tiếp)
import 'package:project/features/authentication/models/user_model.dart'; // Import UserModel
import 'package:project/features/personalization/screens/profile/profile.dart'; // Import màn hình Profile
import 'package:project/repository/auth_repo/AuthenticationRepository.dart'; // Import AuthenticationRepository (có thể không dùng trực tiếp)
import 'package:project/repository/user_repo/user_repo.dart'; // Import userRepo

import '../../../../../common/styles/spacing_styles.dart'; // Import spacing styles (có thể không dùng trực tiếp)
import '../../../../../common/widgets/appbar/appbar.dart'; // Import widget AppBar chung
import '../../../../../common/widgets/login_signup/form_divider.dart'; // Import widget divider (có thể không dùng trực tiếp)
import '../../../../../utils/constants/colors.dart'; // Import màu sắc chuẩn
import '../../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../../../../utils/constants/text_strings.dart'; // Import các chuỗi text chuẩn
import '../../../../authentication/screens/login/widgets/login_form.dart'; // Import login form (có thể không dùng trực tiếp)
import '../../../../authentication/screens/login/widgets/login_header.dart'; // Import login header (có thể không dùng trực tiếp)

class ChangeProfileScreen extends StatelessWidget { // Màn hình thay đổi thông tin profile - StatelessWidget
  final String field; // Biến lưu trường cần thay đổi (hoten, username, phoneNo, gender, dateOfBirth)
  const ChangeProfileScreen({super.key, required this.field}); // Constructor với field parameter bắt buộc
  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    final controller = Get.put(ProfileController()); // Khởi tạo và đăng ký ProfileController vào GetX dependency injection
    final formKey = GlobalKey<FormState>(); // Key để quản lý form state (validate form)
    return Scaffold( // Scaffold - widget cơ bản nhất của Material Design
      appBar: const TAppBar( // AppBar của màn hình
        showBackArrow: true, // Hiển thị nút back
        title: Text('Thay đổi thông tin'), // Tiêu đề "Thay đổi thông tin"
      ),
      body: SingleChildScrollView( // SingleChildScrollView - cho phép cuộn nội dung
          child: Padding( // Padding xung quanh nội dung
              padding: const EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh
              child: FutureBuilder<dynamic>( // FutureBuilder - xây dựng UI dựa trên dữ liệu bất đồng bộ
                  future: controller.getUserData(), // Gọi hàm getUserData() để lấy thông tin user
                  builder: (context, snapshot) { // Builder function để xây dựng UI dựa trên trạng thái của Future
                    if (snapshot.connectionState == ConnectionState.waiting) { // Nếu đang chờ dữ liệu
                      return Center(child: CircularProgressIndicator()); // Hiển thị loading indicator ở giữa màn hình
                    } else if (snapshot.hasError) { // Nếu có lỗi xảy ra
                      return Center(child: Text('Error: ${snapshot.error}')); // Hiển thị thông báo lỗi
                    } else if (!snapshot.hasData || snapshot.data == null) { // Nếu không có dữ liệu
                      return Center(child: Text('No user data available.')); // Hiển thị thông báo không có dữ liệu
                    }
                    UserModel userdata = snapshot.data!; // Lấy dữ liệu user từ snapshot
                    controller.firstName.text =userdata.firstName; // Gán firstName vào TextEditingController
                    controller.lastName.text =userdata.lastName; // Gán lastName vào TextEditingController
                    controller.username.text= userdata.username; // Gán username vào TextEditingController
                    controller.phoneNo.text =userdata.phoneNo; // Gán phoneNo vào TextEditingController
                    if(field == 'hoten'){  return Column( // Nếu field = 'hoten' thì hiển thị form thay đổi họ tên
                      children: [ // Danh sách các widget con
                        Text(TTexts.loginSubTitle, // Text hướng dẫn (có thể không phù hợp, nên dùng text khác)
                            style: Theme.of(context).textTheme.bodyMedium), // Style text từ theme
                        const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa text và TextField
                        TextFormField( // TextField cho firstName
                          controller: controller.firstName, // Gán controller để quản lý text input
                          decoration: const InputDecoration( // Định nghĩa giao diện của TextField
                            prefixIcon: Icon(Iconsax.user), // Icon ở đầu TextField (icon người dùng)
                            labelText: TTexts.firstName, // Label hiển thị "Họ"
                          ),
                        ),
                        const SizedBox( // Khoảng cách giữa firstName và lastName
                            height: TSizes.spaceBtwInputFields * 1.5), // Khoảng cách = spaceBtwInputFields * 1.5
                        TextFormField( // TextField cho lastName
                          controller: controller.lastName, // Gán controller để quản lý text input
                          decoration: const InputDecoration( // Định nghĩa giao diện của TextField
                            prefixIcon: Icon(Iconsax.user), // Icon ở đầu TextField (icon người dùng)
                            labelText: TTexts.lastName, // Label hiển thị "Tên"
                          ),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa lastName và nút
                        SizedBox( // SizedBox để giới hạn kích thước nút
                          width: double.infinity, // Chiều rộng bằng toàn bộ màn hình
                          child: ElevatedButton( // Nút "Thay đổi" (nút chính, có màu nền)
                            onPressed: () async { // Khi click nút
                              UserModel userChange = userdata.copyWith({ // Tạo UserModel mới với firstName và lastName được cập nhật
                                'firstName': controller.firstName.text, // Lấy firstName từ TextEditingController
                                'lastName': controller.lastName.text, // Lấy lastName từ TextEditingController
                              });
                              await userRepo.instance.updateUser(userChange); // Cập nhật user trong database
                              Get.offAll(const ProfileScreen()); // Điều hướng về màn hình Profile và xóa tất cả màn hình trước đó
                            },
                            style: ElevatedButton.styleFrom( // Định nghĩa style cho nút
                                backgroundColor: TColors.primary, // Màu nền primary
                                side: const BorderSide(color: TColors.primary)), // Viền màu primary
                            child: const Text(TTexts.changeProfileName), // Text hiển thị "Thay đổi" (hoặc text tương ứng)
                          ),
                        ),
                      ],
                    );}
                    else if(field =='username') {return Column( // Nếu field = 'username' thì hiển thị form thay đổi username
                      children: [ // Danh sách các widget con
                        Text(TTexts.loginSubTitle, // Text hướng dẫn (có thể không phù hợp, nên dùng text khác)
                            style: Theme.of(context).textTheme.bodyMedium), // Style text từ theme
                        const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa text và TextField
                        TextFormField( // TextField cho username
                          controller: controller.username, // Gán controller để quản lý text input
                          decoration: const InputDecoration( // Định nghĩa giao diện của TextField
                            prefixIcon: Icon(Iconsax.user), // Icon ở đầu TextField (icon người dùng)
                            labelText: TTexts.username, // Label hiển thị "Tên đăng nhập"
                          ),
                        ),
                        const SizedBox( // Khoảng cách giữa TextField và nút
                            height: TSizes.spaceBtwInputFields * 1.5), // Khoảng cách = spaceBtwInputFields * 1.5
                        SizedBox( // SizedBox để giới hạn kích thước nút
                          width: double.infinity, // Chiều rộng bằng toàn bộ màn hình
                          child: ElevatedButton( // Nút "Thay đổi" (nút chính, có màu nền)
                            onPressed: () async { // Khi click nút
                              UserModel userChange = userdata.copyWith({ // Tạo UserModel mới với username được cập nhật
                                'username': controller.username.text, // Lấy username từ TextEditingController
                              });
                              // UserModel(id: userdata.id, gender: userdata.gender, firstName: updateController.firstName.text, lastName: updateController.lastName.text, username: userdata.username, email: userdata.email, password: userdata.password, phoneNo: userdata.phoneNo, dateOfBirth: userdata.dateOfBirth); // Comment code cũ
                              await userRepo.instance.updateUser(userChange); // Cập nhật user trong database
                              Get.offAll(const ProfileScreen()); // Điều hướng về màn hình Profile và xóa tất cả màn hình trước đó
                            },
                            style: ElevatedButton.styleFrom( // Định nghĩa style cho nút
                                backgroundColor: TColors.primary, // Màu nền primary
                                side: const BorderSide(color: TColors.primary)), // Viền màu primary
                            child: const Text(TTexts.changeProfileName), // Text hiển thị "Thay đổi" (hoặc text tương ứng)
                          ),
                        ),
                      ],
                    ); }
                    else if(field =='phoneNo'){return Column( // Nếu field = 'phoneNo' thì hiển thị form thay đổi số điện thoại
                      children: [ // Danh sách các widget con
                        Text(TTexts.loginSubTitle, // Text hướng dẫn (có thể không phù hợp, nên dùng text khác)
                            style: Theme // Style text từ theme
                                .of(context)
                                .textTheme
                                .bodyMedium),
                        const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa text và TextField
                        Form( // Widget Form - quản lý form và validation
                          key: formKey, // Gán key để có thể validate form
                          child: TextFormField( // TextField cho phoneNo
                            controller: controller.phoneNo, // Gán controller để quản lý text input
                            validator: (value) { // Hàm validate: kiểm tra dữ liệu nhập vào
                              if (value == null || value.isEmpty) { // Nếu giá trị null hoặc rỗng
                                return 'Please enter your phone.'; // Trả về thông báo lỗi
                              }
                              final phoneRegex = RegExp(r'^\+84\d{9,10}$'); // Regex pattern để kiểm tra định dạng số điện thoại Việt Nam (+84 + 9-10 chữ số)
                              if (!phoneRegex.hasMatch(value)) { // Nếu số điện thoại không khớp với pattern
                                return 'Phone is not valid.'; // Trả về thông báo lỗi
                              }
                              return null; // Nếu hợp lệ thì trả về null (comment có thể sai, nên là "Phone hợp lệ")
                            },
                            autovalidateMode: AutovalidateMode // Tự động validate khi user tương tác
                                .onUserInteraction,
                            decoration: const InputDecoration( // Định nghĩa giao diện của TextField
                              prefixIcon: Icon(Iconsax.user), // Icon ở đầu TextField (icon người dùng - có thể dùng icon điện thoại)
                              labelText: TTexts.phoneNo, // Label hiển thị "Số điện thoại"
                            ),
                          ),
                        ),
                        const SizedBox( // Khoảng cách giữa TextField và nút
                            height: TSizes.spaceBtwInputFields * 1.5), // Khoảng cách = spaceBtwInputFields * 1.5
                        SizedBox( // SizedBox để giới hạn kích thước nút
                          width: double.infinity, // Chiều rộng bằng toàn bộ màn hình
                          child: ElevatedButton( // Nút "Thay đổi" (nút chính, có màu nền)
                            onPressed: () async { // Khi click nút
                              if(formKey.currentState!.validate()){ // Nếu form hợp lệ (tất cả các field đều pass validation)
                                UserModel userChange = userdata.copyWith({ // Tạo UserModel mới với phoneNo được cập nhật
                                  'phoneNo': controller.phoneNo.text, // Lấy phoneNo từ TextEditingController
                                });
                                await userRepo.instance.updateUser(userChange); // Cập nhật user trong database
                                Get.offAll(const ProfileScreen()); // Điều hướng về màn hình Profile và xóa tất cả màn hình trước đó
                              }; // Kết thúc if
                            },
                            style: ElevatedButton.styleFrom( // Định nghĩa style cho nút
                                backgroundColor: TColors.primary, // Màu nền primary
                                side: const BorderSide(color: TColors.primary)), // Viền màu primary
                            child: const Text(TTexts.changeProfileName), // Text hiển thị "Thay đổi" (hoặc text tương ứng)
                          ),
                        ),
                      ],
                    ); }
                    else if(field =='gender'){return Column( // Nếu field = 'gender' thì hiển thị form thay đổi giới tính
                      children: [ // Danh sách các widget con
                        Text(TTexts.loginSubTitle, // Text hướng dẫn (có thể không phù hợp, nên dùng text khác)
                            style: Theme.of(context).textTheme.bodyMedium), // Style text từ theme
                        const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa text và TextField
                        TextFormField( // TextField cho gender
                          controller: controller.gender, // Gán controller để quản lý text input
                          decoration: const InputDecoration( // Định nghĩa giao diện của TextField
                            prefixIcon: Icon(Iconsax.user), // Icon ở đầu TextField (icon người dùng)
                            labelText: 'Gender', // Label hiển thị "Gender" (hardcode, nên dùng TTexts)
                          ),
                        ),
                        const SizedBox( // Khoảng cách giữa TextField và nút
                            height: TSizes.spaceBtwInputFields * 1.5), // Khoảng cách = spaceBtwInputFields * 1.5
                        SizedBox( // SizedBox để giới hạn kích thước nút
                          width: double.infinity, // Chiều rộng bằng toàn bộ màn hình
                          child: ElevatedButton( // Nút "Thay đổi" (nút chính, có màu nền)
                            onPressed: () async { // Khi click nút
                              UserModel userChange = userdata.copyWith({ // Tạo UserModel mới với gender được cập nhật
                                'gender': controller.gender.text, // Lấy gender từ TextEditingController
                              });
                              await userRepo.instance.updateUser(userChange); // Cập nhật user trong database
                              Get.offAll(const ProfileScreen()); // Điều hướng về màn hình Profile và xóa tất cả màn hình trước đó
                            },
                            style: ElevatedButton.styleFrom( // Định nghĩa style cho nút
                                backgroundColor: TColors.primary, // Màu nền primary
                                side: const BorderSide(color: TColors.primary)), // Viền màu primary
                            child: const Text(TTexts.changeProfileName), // Text hiển thị "Thay đổi" (hoặc text tương ứng)
                          ),
                        ),
                      ],
                    );}
                    else if(field =='dateOfBirth'){return Column( // Nếu field = 'dateOfBirth' thì hiển thị form thay đổi ngày sinh
                      children: [ // Danh sách các widget con
                        Text(TTexts.loginSubTitle, // Text hướng dẫn (có thể không phù hợp, nên dùng text khác)
                            style: Theme.of(context).textTheme.bodyMedium), // Style text từ theme
                        const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa text và TextField
                        TextFormField( // TextField cho dateOfBirth
                          controller: controller.dateOrBirth, // Gán controller để quản lý text input (có typo: dateOrBirth thay vì dateOfBirth)
                          decoration: const InputDecoration( // Định nghĩa giao diện của TextField
                            prefixIcon: Icon(Iconsax.user), // Icon ở đầu TextField (icon người dùng - có thể dùng icon lịch)
                            labelText: 'Date of birth', // Label hiển thị "Date of birth" (hardcode, nên dùng TTexts)
                          ),
                        ),
                        const SizedBox( // Khoảng cách giữa TextField và nút
                            height: TSizes.spaceBtwInputFields * 1.5), // Khoảng cách = spaceBtwInputFields * 1.5
                        SizedBox( // SizedBox để giới hạn kích thước nút
                          width: double.infinity, // Chiều rộng bằng toàn bộ màn hình
                          child: ElevatedButton( // Nút "Thay đổi" (nút chính, có màu nền)
                            onPressed: () async { // Khi click nút
                              UserModel userChange = userdata.copyWith({ // Tạo UserModel mới với dateOfBirth được cập nhật
                                'dateOfBirth': controller.dateOrBirth.text, // Lấy dateOfBirth từ TextEditingController (có typo: dateOrBirth)
                              });

                              await userRepo.instance.updateUser(userChange); // Cập nhật user trong database
                              Get.offAll(const ProfileScreen()); // Điều hướng về màn hình Profile và xóa tất cả màn hình trước đó
                            },
                            style: ElevatedButton.styleFrom( // Định nghĩa style cho nút
                                backgroundColor: TColors.primary, // Màu nền primary
                                side: const BorderSide(color: TColors.primary)), // Viền màu primary
                            child: const Text(TTexts.changeProfileName), // Text hiển thị "Thay đổi" (hoặc text tương ứng)
                          ),
                        ),
                      ],
                    );}
                    return SizedBox.shrink(); // Nếu field không khớp với bất kỳ trường hợp nào thì trả về SizedBox rỗng (không hiển thị gì)
                  }))),
    );
  }
}
