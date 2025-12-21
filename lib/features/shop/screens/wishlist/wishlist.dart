import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho navigation và state management
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax
import 'package:project/common/widgets/icons/t_circular_icon.dart'; // Import widget icon tròn

import '../../../../common/widgets/appbar/appbar.dart'; // Import widget AppBar chung
import '../../../../common/widgets/layouts/grid_layout.dart'; // Import widget layout dạng grid
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart'; // Import widget card sản phẩm dọc
import '../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../../../utils/navigation_menu.dart'; // Import màn hình navigation menu
import '../home/home.dart'; // Import màn hình Home (có thể không dùng trực tiếp)

class FavouriteScreen extends StatelessWidget { // Màn hình Wishlist (Danh sách yêu thích) - StatelessWidget
  const FavouriteScreen({super.key}); // Constructor với key từ parent widget

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    return Scaffold( // Scaffold - widget cơ bản nhất của Material Design
      appBar: TAppBar( // AppBar của màn hình Wishlist
        title: Text( // Tiêu đề "Wishlist"
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium, // Style tiêu đề từ theme
        ),
        actions: [ // Danh sách các action button trên AppBar
          TCircularIcon( // Widget icon tròn
            icon: Iconsax.add, // Icon dấu cộng
            onPressed: () { // Callback khi click icon
              final NavigationController controller = Get.find<NavigationController>(); // Lấy instance của NavigationController
              controller.selectedIndex.value = 0; // Đặt selectedIndex = 0 (trang Home)
              Get.to(() => const NavigationMenu()); // Navigate đến NavigationMenu (có thể không cần vì đã ở trong NavigationMenu)
            },
          ),

        ],
      ),
      body: SingleChildScrollView( // SingleChildScrollView - cho phép cuộn nội dung
        child: Padding( // Padding xung quanh nội dung
          padding: const EdgeInsets.only(left: TSizes.defaultSpace), // Chỉ padding bên trái
          child: Column( // Column - sắp xếp các widget theo chiều dọc
            children: [ // Danh sách các widget con
             /* TGridLayout( // Comment code - widget grid layout hiển thị sản phẩm yêu thích
                itemCount: 2, // Số lượng sản phẩm (hardcode = 2)
                itemBuilder: (_, index) => const TProductCardVertical(), // Builder function để tạo ProductCardVertical
              ),  */
            ],
          ),
        ),
      ),
    );
  }
}
