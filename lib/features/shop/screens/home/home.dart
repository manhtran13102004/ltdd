// File màn hình Home - màn hình chính của app, hiển thị banner, danh mục, sản phẩm nổi bật

import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho state management và navigation
import 'package:get/get_core/src/get_main.dart'; // Import GetX core (có thể không cần thiết)
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax (có thể không dùng trực tiếp ở đây)
import 'package:project/features/shop/screens/home/widgets/home_appbar.dart'; // Import widget AppBar của màn hình Home
import 'package:project/features/shop/screens/home/widgets/home_categories.dart'; // Import widget hiển thị danh mục trên Home
import 'package:project/features/shop/screens/home/widgets/promo_slider.dart'; // Import widget slider banner khuyến mãi

import '../../../../common/widgets/appbar/appbar.dart'; // Import widget AppBar chung (có thể không dùng trực tiếp)
import '../../../../common/widgets/containers/circular_container.dart'; // Import widget container tròn (có thể không dùng trực tiếp)
import '../../../../common/widgets/containers/primary_header_container.dart'; // Import widget container header chính (nền màu primary)
import '../../../../common/widgets/containers/search_container.dart'; // Import widget container tìm kiếm
import '../../../../common/widgets/curved_edges/curved_edges.dart'; // Import widget curved edges (có thể không dùng trực tiếp)
import '../../../../common/widgets/image_text_widgets/vertical_image_text.dart'; // Import widget image text dọc (có thể không dùng trực tiếp)
import '../../../../common/widgets/images/t_rounded_image.dart'; // Import widget hình ảnh bo góc (có thể không dùng trực tiếp)
import '../../../../common/widgets/layouts/grid_layout.dart'; // Import widget layout dạng grid
import '../../../../common/widgets/products/cart/cart_menu_icon.dart'; // Import widget icon giỏ hàng (có thể không dùng trực tiếp)
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart'; // Import widget card sản phẩm dọc
import '../../../../common/widgets/products/product_cards/product_card_horizontal.dart'; // Import widget card sản phẩm dọc
import '../../../../common/widgets/texts/section_heading.dart'; // Import widget tiêu đề section
import '../../../../utils/constants/colors.dart'; // Import màu sắc chuẩn
import '../../../../utils/constants/image_strings.dart'; // Import đường dẫn hình ảnh chuẩn (có thể không dùng trực tiếp)
import '../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../../../utils/constants/text_strings.dart'; // Import các chuỗi text chuẩn (có thể không dùng trực tiếp)
import '../../../../utils/device/device_utility.dart'; // Import utility để lấy kích thước thiết bị (có thể không dùng trực tiếp)
import '../../../../utils/helpers/helper_functions.dart'; // Import các hàm helper (có thể không dùng trực tiếp)
import '../../controllers/product/product_controller.dart'; // Import controller xử lý logic sản phẩm
import '../all_products/all_products.dart'; // Import màn hình tất cả sản phẩm
import '../brand/all_brands.dart'; // Import màn hình tất cả thương hiệu

class HomeScreen extends StatelessWidget { // Màn hình Home - StatelessWidget
  const HomeScreen({super.key}); // Constructor với key từ parent widget

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    final controller = Get.put(ProductController()); // Khởi tạo và đăng ký ProductController vào GetX dependency injection

    return  Scaffold( // Scaffold - widget cơ bản nhất của Material Design

      body: SingleChildScrollView( // SingleChildScrollView - cho phép cuộn nội dung
        child: Column( // Column - sắp xếp các widget theo chiều dọc
          children: [ // Danh sách các widget con
            TPrimaryHeaderContainer( // Container header chính với nền màu primary
              child: Column( // Column chứa các widget trong header
                children: [ // Danh sách các widget con

                  const THomeAppBar(), // Widget AppBar của màn hình Home (logo, icon giỏ hàng, thông báo)
                  const SizedBox(height: TSizes.spaceBtwSections,), // Khoảng cách giữa AppBar và SearchContainer

                  const TSearchContainer(text: 'Tìm kiếm'), // Widget container tìm kiếm với placeholder "Tìm kiếm"
                  const SizedBox(height: TSizes.spaceBtwSections,), // Khoảng cách giữa SearchContainer và SectionHeading


                  Padding( // Padding để thêm khoảng cách bên trái
                    padding: const EdgeInsets.only(left: TSizes.defaultSpace), // Chỉ padding bên trái
                    child: Column( // Column chứa danh mục phổ biến
                      children: [ // Danh sách các widget con
                         TSectionHeading(title: 'Danh mục phổ biến', onPressed: () => Get.to(() => const AllBrandScreen()), textColor: TColors.white,), // Tiêu đề section "Danh mục phổ biến" - khi click sẽ navigate đến màn hình AllBrandScreen, màu chữ trắng
                         const SizedBox(height: TSizes.spaceBtwItems,), // Khoảng cách giữa tiêu đề và danh mục
                         const THomeCategories(), // Widget hiển thị danh sách danh mục phổ biến
                         const SizedBox(height: TSizes.spaceBtwSections,), // Khoảng cách giữa danh mục và phần tiếp theo
                      ],
                    ),

                  ),
                ],
              ),
            ),
            // Phần nội dung chính bên dưới header
            Padding( // Padding xung quanh nội dung chính
              padding: const EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh
              child: Column( // Column chứa nội dung chính
                children: [ // Danh sách các widget con
                  const TPromoSlider(), // Widget slider hiển thị banner khuyến mãi
                  const SizedBox(height: TSizes.spaceBtwSections,), // Khoảng cách giữa slider và tiêu đề section

                  TSectionHeading(title: 'Sản phẩm bán chạy', onPressed: () => Get.to(() => const AllProduct()), textColor: TColors.dark,  ), // Tiêu đề section "Sản phẩm bán chạy" - khi click sẽ navigate đến màn hình AllProduct, màu chữ đen
                  const SizedBox(height: TSizes.spaceBtwItems,), // Khoảng cách giữa tiêu đề và danh sách sản phẩm

                  Obx(() { // Obx - tự động rebuild khi featuredProducts thay đổi
                    if (controller.featuredProducts.isEmpty) { // Nếu không có sản phẩm nổi bật
                      return const Center(child: Text("Không có sản phẩm nào", style: TextStyle(color: TColors.primary))); // Hiển thị text "Không có sản phẩm nào" màu primary, căn giữa
                    }
                    return TGridLayout( // Widget layout dạng grid để hiển thị sản phẩm
                      itemCount: controller.featuredProducts.length, // Số lượng sản phẩm = độ dài của featuredProducts
                      itemBuilder: (_, index) { // Builder function để tạo widget cho mỗi item

                        return TProductCardVertical(product: controller.featuredProducts[index]); // Trả về ProductCardVertical với sản phẩm tương ứng
                      },
                    );
                  })

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}












