import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth (có thể không dùng trực tiếp)
import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho state management và navigation
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax
import 'package:project/features/authentication/controllers.onboarding/profile_controller.dart'; // Import ProfileController
import 'package:project/features/authentication/models/user_model.dart'; // Import UserModel
import 'package:project/features/authentication/screens/login/login.dart'; // Import màn hình đăng nhập

import 'package:project/features/personalization/screens/profile/widgets/profile_menu.dart'; // Import widget menu profile

import '../../../../common/widgets/appbar/appbar.dart'; // Import widget AppBar chung
import '../../../../common/widgets/images/t_circular_image.dart'; // Import widget hình ảnh tròn
import '../../../../common/widgets/texts/section_heading.dart'; // Import widget tiêu đề section
import '../../../../utils/constants/colors.dart'; // Import màu sắc chuẩn
import '../../../../utils/constants/image_strings.dart'; // Import đường dẫn hình ảnh chuẩn
import '../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn

import '../../../shop/controllers/category_controller.dart'; // Import CategoryController (dùng để upload ảnh đại diện)
import 'change_profile/change_profile.dart'; // Import màn hình thay đổi thông tin profile

class ProfileScreen extends StatelessWidget { // Màn hình Profile - StatelessWidget
  const ProfileScreen({super.key}); // Constructor với key từ parent widget



  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    final controller = Get.put(ProfileController()); // Khởi tạo và đăng ký ProfileController vào GetX dependency injection



    return Scaffold( // Scaffold - widget cơ bản nhất của Material Design
      appBar: const TAppBar( // AppBar của màn hình Profile
        showBackArrow: true, // Hiển thị nút back
        title: Text('Profile'), // Tiêu đề "Profile"
      ),
      body: SingleChildScrollView( // SingleChildScrollView - cho phép cuộn nội dung
        child: Padding( // Padding xung quanh nội dung
          padding: const EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh
          child: FutureBuilder<dynamic>( // FutureBuilder - xây dựng UI dựa trên dữ liệu bất đồng bộ
            future: controller.getUserData(), // Gọi hàm getUserData() để lấy thông tin user
            builder: (context, snapshot) { // Builder function để xây dựng UI dựa trên trạng thái của Future

              if (snapshot.connectionState == ConnectionState.waiting) { // Nếu đang chờ dữ liệu
                return const Center(child: CircularProgressIndicator()); // Hiển thị loading indicator ở giữa màn hình
              }

              // Check if there was an error
              else if (snapshot.hasError) { // Nếu có lỗi xảy ra
                return Center( // Căn giữa widget
                    child: Column( // Column chứa thông báo lỗi và nút
                        mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều dọc
                        children: [ // Danh sách các widget con
                      const Text('An error occurred. Please try again later.'), // Text thông báo lỗi
                      ElevatedButton( // Nút "Go to Login"
                        onPressed: () { // Khi click nút
                          controller.logOut(); // Gọi hàm logOut từ controller
                          Get.offAll(() => const LoginScreen()); // Điều hướng đến màn hình đăng nhập và xóa tất cả màn hình trước đó
                        },
                        child: const Text("Go to Login"), // Text hiển thị "Go to Login"
                      ),
                    ]));
                //logout
              }

              // Check if we received data
              else if (snapshot.hasData) { // Nếu có dữ liệu
                UserModel userdata = snapshot.data!; // Lấy dữ liệu user từ snapshot
                return _buildProfileContent(userdata); // Gọi hàm _buildProfileContent để xây dựng nội dung profile
              }

              // Handle case where snapshot is empty
              return const Center(child: Text('No data found')); // Nếu không có dữ liệu thì hiển thị "No data found"
            },
          ),
        ),
      ),
    );
  }

  // A helper method to build profile content
  Widget _buildProfileContent(UserModel userdata) { // Hàm helper để xây dựng nội dung profile
    final controller = Get.put(ProfileController()); // Lấy instance của ProfileController
   final categoryController = Get.put(CategoryController()); // Lấy instance của CategoryController (dùng để upload ảnh đại diện)

    return Column( // Column - sắp xếp các widget theo chiều dọc
      children: [ // Danh sách các widget con
        SizedBox( // SizedBox để giới hạn kích thước
          width: double.infinity, // Chiều rộng bằng toàn bộ màn hình
          child: Column(children: [ // Column chứa ảnh đại diện và nút thay đổi
            const TCircularImage( // Widget hình ảnh tròn hiển thị ảnh đại diện
              image: TImages.user, // Đường dẫn ảnh đại diện (hardcode, nên lấy từ userdata)
              isNetworkImage: false, // Không phải ảnh từ network
              width: 80, // Chiều rộng 80 pixels
              height: 80, // Chiều cao 80 pixels
            ),

            TextButton( // Nút "Change Profile Picture"
              onPressed: () async { // Khi click nút
                // Chờ phương thức uploadPicture hoàn thành
                await categoryController.uploadPicture(); // Gọi hàm uploadPicture từ CategoryController để upload ảnh đại diện
              },
              child: const Text("Change Profile Picture"), // Text hiển thị "Change Profile Picture"
            ),



          ]),
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2), // Khoảng cách giữa phần ảnh đại diện và divider
        const Divider(), // Đường kẻ ngang phân cách
        const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách giữa divider và section "Thông Tin Tài Khoản"
        const TSectionHeading( // Tiêu đề section "Thông Tin Tài Khoản"
          title: 'Thông Tin Tài Khoản', // Text tiêu đề
          showActionButton: false, // Không hiển thị nút action
          textColor: TColors.black, // Màu chữ đen
        ),
        const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách giữa tiêu đề và menu items
        TProfileMenu( // Menu item "Họ & Tên"
          title: 'Họ & Tên', // Tiêu đề menu item
          value: '${userdata.firstName ?? ''} ${userdata.lastName ?? ''}'.trim().isNotEmpty // Giá trị hiển thị: nếu firstName và lastName không rỗng thì hiển thị đầy đủ
              ? '${userdata.firstName} ${userdata.lastName}' // Hiển thị "firstName lastName"
              :  'Chưa cập nhập', // Ngược lại hiển thị "Chưa cập nhập"
          onPressed: () => Get.to(() =>    const ChangeProfileScreen( field: 'hoten',)), // Khi click, navigate đến màn hình thay đổi họ tên
        ),
        TProfileMenu( // Menu item "Username"
          title: 'Username', // Tiêu đề menu item
          value: userdata.username.isNotEmpty? userdata.username: 'Chưa cập nhập', // Giá trị hiển thị: nếu username không rỗng thì hiển thị username, ngược lại "Chưa cập nhập"
          onPressed: () => Get.to(() =>   const  ChangeProfileScreen( field: 'username',)), // Khi click, navigate đến màn hình thay đổi username
        ),
        const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách giữa menu items và divider
        const Divider(), // Đường kẻ ngang phân cách
        const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách giữa divider và section "Thông Tin Cá Nhân"
        const TSectionHeading( // Tiêu đề section "Thông Tin Cá Nhân"
          title: 'Thông Tin Cá Nhân', // Text tiêu đề
          showActionButton: false, // Không hiển thị nút action
          textColor: TColors.black, // Màu chữ đen
        ),
        const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách giữa tiêu đề và menu items
        TProfileMenu( // Menu item "User ID"
          title: 'User ID', // Tiêu đề menu item
          value: userdata.id, // Giá trị hiển thị: ID của user
          icon: Iconsax.copy, // Icon copy (để copy User ID)
          onPressed: () {}, // Callback khi click (chưa được implement - nên thêm chức năng copy)
        ),
        TProfileMenu( // Menu item "Email"
          title: 'Email', // Tiêu đề menu item
          value: userdata.email, // Giá trị hiển thị: email của user
          onPressed: () {}, // Callback khi click (chưa được implement)
        ),
        TProfileMenu( // Menu item "Phone Number"
          title: 'Phone Number', // Tiêu đề menu item
          value: userdata.phoneNo.isNotEmpty? userdata.phoneNo: 'Chưa cập nhập', // Giá trị hiển thị: nếu phoneNo không rỗng thì hiển thị phoneNo, ngược lại "Chưa cập nhập"
          onPressed: ()=> Get.to(() =>   const  ChangeProfileScreen( field: 'phoneNo')), // Khi click, navigate đến màn hình thay đổi số điện thoại
        ),
        TProfileMenu( // Menu item "Gender"
          title: 'Gender', // Tiêu đề menu item
          value:userdata.gender.isNotEmpty ? userdata.gender:'Chưa cập nhập' // Giá trị hiển thị: nếu gender không rỗng thì hiển thị gender, ngược lại "Chưa cập nhập"
, // Có dấu phẩy thừa
          onPressed: () => Get.to(() =>   const  ChangeProfileScreen( field: 'gender')), // Khi click, navigate đến màn hình thay đổi giới tính
        ),
        TProfileMenu( // Menu item "Date of Birth"
          title: 'Date of Birth', // Tiêu đề menu item
          value: userdata.dateOfBirth.isNotEmpty? userdata.dateOfBirth:'Chưa cập nhập', // Giá trị hiển thị: nếu dateOfBirth không rỗng thì hiển thị dateOfBirth, ngược lại "Chưa cập nhập"
          onPressed: () => Get.to(() =>   const  ChangeProfileScreen( field: 'dateOfBirth')), // Khi click, navigate đến màn hình thay đổi ngày sinh
        ),
        const Divider(), // Đường kẻ ngang phân cách
        const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách giữa divider và các nút
        Row( // Row để sắp xếp các nút theo chiều ngang
          children: [ // Danh sách các widget con
            TextButton( // Nút "Close Account" (xóa tài khoản)
              onPressed: ()  { // Khi click nút
                controller.deleteUser(userdata); // Gọi hàm deleteUser từ controller để xóa tài khoản
              },
              child: const Text( // Text hiển thị "Close Account"
                "Close Account",
                style: TextStyle(color: Colors.red), // Màu chữ đỏ
              ),
            ),
            TextButton( // Nút "Edit profile" (chỉnh sửa profile)
              onPressed: () {}, // Callback khi click (chưa được implement - có thể navigate đến màn hình edit profile tổng hợp)
              child: const Text( // Text hiển thị "Edit profile"
                "Edit profile",
                style: TextStyle(color: Colors.green), // Màu chữ xanh
              ),
            ),
          ],
        ),
      ],
    );
  }
}
