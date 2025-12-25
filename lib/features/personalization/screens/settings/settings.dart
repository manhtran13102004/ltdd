import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho state management và navigation
import 'package:get/get_core/src/get_main.dart'; // Import GetX core (có thể không cần thiết)
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax
import 'package:project/common/widgets/images/t_circular_image.dart'; // Import widget hình ảnh tròn (có thể không dùng trực tiếp)

import '../../../../common/widgets/appbar/appbar.dart'; // Import widget AppBar chung
import '../../../../common/widgets/containers/primary_header_container.dart'; // Import widget container header chính (nền màu primary)
import '../../../../common/widgets/list_titles/settings_menu_title.dart'; // Import widget menu item trong settings
import '../../../../common/widgets/list_titles/user_profile_title.dart'; // Import widget tiêu đề user profile
import '../../../../common/widgets/texts/section_heading.dart'; // Import widget tiêu đề section
import '../../../../utils/constants/colors.dart'; // Import màu sắc chuẩn
import '../../../../utils/constants/image_strings.dart'; // Import đường dẫn hình ảnh chuẩn (có thể không dùng trực tiếp)
import '../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../../authentication/controllers.onboarding/profile_controller.dart'; // Import ProfileController
import '../../../shop/screens/order/order.dart'; // Import màn hình đơn hàng
import '../address/address.dart'; // Import màn hình địa chỉ
import '../profile/profile.dart'; // Import màn hình profile

import 'package:project/features/shop/screens/cart/cart.dart'; // Import màn hình profile

class SettingsScreen extends StatelessWidget { // Màn hình Settings - StatelessWidget
   SettingsScreen({super.key}); // Constructor với key từ parent widget
  final controller = Get.put(ProfileController()); // Khởi tạo và đăng ký ProfileController vào GetX dependency injection
  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    return Scaffold( // Scaffold - widget cơ bản nhất của Material Design
      body: SingleChildScrollView( // SingleChildScrollView - cho phép cuộn nội dung
        child: Column( // Column - sắp xếp các widget theo chiều dọc
          children: [ // Danh sách các widget con

          TPrimaryHeaderContainer( // Container header chính với nền màu primary
            child: Column( // Column chứa các widget trong header
              children: [ // Danh sách các widget con
                 TAppBar(title: Text('Account', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white),),), // AppBar với tiêu đề "Account" màu trắng
                  TUserProfileTitle(onPressed: () => Get.to(() => const ProfileScreen())), // Widget tiêu đề user profile - khi click sẽ navigate đến màn hình Profile
                  const SizedBox(height: TSizes.spaceBtwSections,), // Khoảng cách giữa UserProfileTitle và phần tiếp theo
              ],
            ),
          ),

          Padding( // Padding xung quanh nội dung settings
              padding: const EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh
              child: Column( // Column chứa các menu items
                children: [ // Danh sách các widget con
                  const TSectionHeading(title: 'Account Settings', textColor: TColors.black,showActionButton: false,), // Tiêu đề section "Account Settings" với màu chữ đen, không có nút action
                  const SizedBox(height: TSizes.spaceBtwItems,), // Khoảng cách giữa tiêu đề và menu items

                  TSettingsMenuTitle(icon: Iconsax.safe_home, title: 'My Address', subTitle: 'Thông tin vận chuyển', onTap: () => Get.to(() => const UserAddressScreen())), // Menu item "My Address" - khi click sẽ navigate đến màn hình địa chỉ
                  TSettingsMenuTitle(icon: Iconsax.shopping_cart, title: 'My Cart', subTitle: 'Giỏ hàng của tôi', onTap: () => Get.to(() => CartScreen()),), // Menu item "My Cart" - callback chưa được implement
                  TSettingsMenuTitle(icon: Iconsax.bag_tick, title: 'My Orders', subTitle: 'Đơn hàng của tôi',onTap: () => Get.to(() => const OrderScreen ())), // Menu item "My Orders" - khi click sẽ navigate đến màn hình đơn hàng
                  TSettingsMenuTitle(icon: Iconsax.bank, title: 'Bank Account', subTitle: 'Set shopping delivery address', onTap: (){},), // Menu item "Bank Account" - callback chưa được implement (subTitle có thể sai)
                  TSettingsMenuTitle(icon: Iconsax.discount_shape, title: 'My Coupons', subTitle: 'Set shopping delivery address', onTap: (){},), // Menu item "My Coupons" - callback chưa được implement (subTitle có thể sai)
                  TSettingsMenuTitle(icon: Iconsax.notification, title: 'Notifications', subTitle: 'Set shopping delivery address', onTap: (){},), // Menu item "Notifications" - callback chưa được implement (subTitle có thể sai)
                  TSettingsMenuTitle(icon: Iconsax.safe_home, title: 'Account Privacy', subTitle: 'Set shopping delivery address', onTap: (){},), // Menu item "Account Privacy" - callback chưa được implement (subTitle có thể sai)

                  const SizedBox(height: TSizes.spaceBtwSections,), // Khoảng cách giữa section "Account Settings" và "App Settings"
                  const TSectionHeading(title: 'App Settings', textColor: TColors.black,showActionButton: false,), // Tiêu đề section "App Settings" với màu chữ đen, không có nút action
                  const SizedBox(height: TSizes.spaceBtwItems,), // Khoảng cách giữa tiêu đề và menu items

                  TSettingsMenuTitle(icon: Iconsax.document_cloud, title: 'Load data', subTitle: 'Set shopping delivery address', onTap: (){},), // Menu item "Load data" - callback chưa được implement (subTitle có thể sai)
                  TSettingsMenuTitle(icon: Iconsax.location, title: 'Geolocations', subTitle: 'Set shopping delivery address', trailing: Switch(value:true, onChanged: (value) {})), // Menu item "Geolocations" với Switch (bật/tắt) - giá trị mặc định = true, callback chưa được implement (subTitle có thể sai)
                  TSettingsMenuTitle(icon: Iconsax.security_user, title: 'Safe Mode', subTitle: 'Set shopping delivery address', trailing: Switch(value:false, onChanged: (value) {})), // Menu item "Safe Mode" với Switch (bật/tắt) - giá trị mặc định = false, callback chưa được implement (subTitle có thể sai)
                  TSettingsMenuTitle(icon: Iconsax.image, title: 'HD Image Quality', subTitle: 'Set shopping delivery address', trailing: Switch(value:false, onChanged: (value) {})), // Menu item "HD Image Quality" với Switch (bật/tắt) - giá trị mặc định = false, callback chưa được implement (subTitle có thể sai)

                  const SizedBox(height: TSizes.spaceBtwSections,), // Khoảng cách giữa menu items và nút đăng xuất
                   SizedBox( // SizedBox để giới hạn kích thước nút
                     width: double.infinity, // Chiều rộng bằng toàn bộ màn hình
                     child: OutlinedButton(onPressed: () async { // Nút "Đăng Xuất" (nút phụ, chỉ có viền)
                       await controller.logOut(); // Gọi hàm logOut từ controller để đăng xuất
                     }, child: const Text('Đăng Xuất' )), // Text hiển thị "Đăng Xuất"
                   ),
                  const SizedBox(height: TSizes.spaceBtwSections * 2,), // Khoảng cách cuối cùng (gấp đôi khoảng cách chuẩn)

                ],
              ),

          )


          ],
        ),
      ),
    );
  }
}

