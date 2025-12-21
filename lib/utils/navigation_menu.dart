import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho state management và navigation
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax
import 'package:project/features/shop/screens/store/store.dart'; // Import màn hình Store
import 'package:project/utils/constants/colors.dart'; // Import màu sắc chuẩn

import '../features/personalization/screens/settings/settings.dart'; // Import màn hình Settings
import '../features/shop/screens/home/home.dart'; // Import màn hình Home
import '../features/shop/screens/wishlist/wishlist.dart'; // Import màn hình Wishlist
import 'helpers/helper_functions.dart'; // Import các hàm helper

class NavigationMenu extends StatelessWidget { // Widget menu điều hướng chính - StatelessWidget
  const NavigationMenu({super.key}); // Constructor với key từ parent widget

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI

    final controller = Get.put(NavigationController()); // Khởi tạo và đăng ký NavigationController vào GetX dependency injection
    final darkMode = THelperFunctions.isDarkMode(context); // Kiểm tra chế độ dark mode

    return Scaffold( // Scaffold - widget cơ bản nhất của Material Design
      bottomNavigationBar: Obx( // Obx - tự động rebuild khi selectedIndex thay đổi
        () => NavigationBar( // NavigationBar - thanh điều hướng ở dưới cùng màn hình
             height: 80, // Chiều cao của navigation bar là 80 pixels
             elevation: 0, // Không có đổ bóng (elevation = 0)
             selectedIndex: controller.selectedIndex.value, // Chỉ số tab đang được chọn
             onDestinationSelected: (index) => controller.selectedIndex.value = index, // Callback khi click vào một tab - cập nhật selectedIndex
             backgroundColor: darkMode ? TColors.black : TColors.white, // Màu nền: nếu dark mode thì đen, ngược lại trắng
             indicatorColor: darkMode ? TColors.white.withOpacity(0.1) : TColors.black.withOpacity(0.1), // Màu indicator: nếu dark mode thì trắng mờ, ngược lại đen mờ
             destinations: const [ // Danh sách các tab trong navigation bar
              NavigationDestination(icon: Icon(Iconsax.home), label: 'Home',), // Tab Home với icon nhà
              NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store',), // Tab Store với icon cửa hàng
              NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist',), // Tab Wishlist với icon tim
              NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile',), // Tab Profile với icon người dùng
            ]
        ),
      ) ,

      body: Obx(() =>controller.screens[controller.selectedIndex.value]), // Body hiển thị màn hình tương ứng với tab được chọn - Obx để tự động rebuild khi selectedIndex thay đổi
    );
  }
}

class NavigationController extends GetxController{ // Controller quản lý navigation - kế thừa GetxController
  final Rx<int> selectedIndex = 0.obs; // Observable để lưu chỉ số tab đang được chọn (mặc định = 0 = Home)

  final screens = [const HomeScreen(), const StoreScreen(), const FavouriteScreen(),  SettingsScreen()]; // Danh sách các màn hình tương ứng với các tab (Home, Store, Wishlist, Settings)
}