import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax
import 'package:project/common/widgets/appbar/appbar.dart'; // Import widget AppBar chung
import 'package:project/common/widgets/icons/t_circular_icon.dart'; // Import widget icon tròn (có thể không dùng trực tiếp)
import 'package:project/common/widgets/layouts/grid_layout.dart'; // Import widget layout dạng grid
import 'package:project/features/shop/screens/store/widgets/category_tab.dart'; // Import widget tab hiển thị sản phẩm theo danh mục
import 'package:project/utils/constants/enums.dart'; // Import enums (có thể không dùng trực tiếp)
import 'package:project/utils/constants/image_strings.dart'; // Import đường dẫn hình ảnh chuẩn (có thể không dùng trực tiếp)
import 'package:project/utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../../../common/widgets/appbar/tabbar.dart'; // Import widget TabBar tùy chỉnh
import '../../../../common/widgets/brand/brand_show_case.dart'; // Import widget showcase thương hiệu (có thể không dùng trực tiếp)
import '../../../../common/widgets/brand/brandcard.dart'; // Import widget card thương hiệu
import '../../../../common/widgets/containers/rounded_container.dart'; // Import widget container bo góc (có thể không dùng trực tiếp)
import '../../../../common/widgets/containers/search_container.dart'; // Import widget container tìm kiếm
import '../../../../common/widgets/images/t_circular_image.dart'; // Import widget hình ảnh tròn (có thể không dùng trực tiếp)
import '../../../../common/widgets/products/cart/cart_menu_icon.dart'; // Import widget icon giỏ hàng
import '../../../../common/widgets/texts/section_heading.dart'; // Import widget tiêu đề section
import '../../../../common/widgets/texts/t_brand_title_with_verified_icon.dart'; // Import widget tiêu đề thương hiệu với icon verified (có thể không dùng trực tiếp)
import '../../../../utils/constants/colors.dart'; // Import màu sắc chuẩn
import '../../../../utils/helpers/helper_functions.dart'; // Import các hàm helper
import '../../controllers/category_controller.dart'; // Import controller xử lý logic danh mục

class StoreScreen extends StatelessWidget { // Màn hình Store - StatelessWidget
  const StoreScreen({super.key}); // Constructor với key từ parent widget

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    final categories = CategoryController.instance.allCategories; // Lấy danh sách tất cả danh mục từ CategoryController
    return DefaultTabController( // DefaultTabController - quản lý TabBar và TabBarView
      length: categories.length, // Số lượng tab = số lượng danh mục
      child: Scaffold( // Scaffold - widget cơ bản nhất của Material Design
        appBar: TAppBar( // AppBar của màn hình Store
          title: Text( // Tiêu đề "Store"
            'Store',
            style: Theme.of(context).textTheme.headlineMedium, // Style tiêu đề từ theme
          ),
          actions: [ // Danh sách các action button trên AppBar
            TCartCounterIcon( // Widget icon giỏ hàng với số lượng
              onPressed: () {}, // Callback khi click (chưa được implement)
              iconColor: TColors.black, // Màu icon đen
              iconColor2: TColors.white, // Màu icon thứ 2 trắng (có thể là màu badge)
            )
          ],
        ),
        body: NestedScrollView( // NestedScrollView - cho phép scroll header và body độc lập
          headerSliverBuilder: (context, innerBoxIsScrolled) { // Builder function để tạo header (SliverAppBar)
            return [ // Trả về danh sách các Sliver widget
              SliverAppBar( // SliverAppBar - AppBar có thể cuộn và thu gọn
                automaticallyImplyLeading: false, // Tắt nút back mặc định
                pinned: true, // Pin AppBar ở trên cùng khi scroll
                floating: true, // Cho phép AppBar hiển thị ngay khi scroll lên
                backgroundColor: THelperFunctions.isDarkMode(context) // Màu nền AppBar
                    ? TColors.black // Nếu dark mode thì đen
                    : TColors.white, // Ngược lại trắng
                expandedHeight: 440, // Chiều cao khi mở rộng (440 pixels)
                flexibleSpace: Padding( // Padding xung quanh nội dung trong flexibleSpace
                  padding: const EdgeInsets.all(TSizes.defaultSpace), // Padding chuẩn cho tất cả các cạnh
                  child: ListView( // ListView chứa nội dung trong header
                    shrinkWrap: true, // Thu gọn kích thước theo nội dung
                    physics: const NeverScrollableScrollPhysics(), // Không cho phép scroll độc lập (scroll theo NestedScrollView)
                    children: [ // Danh sách các widget con
                      const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách đầu tiên
                      const TSearchContainer( // Widget container tìm kiếm
                        text: 'Tìm kiếm', // Placeholder text
                        showBorder: true, // Hiển thị viền
                        showBackground: false, // Không hiển thị nền
                        padding: EdgeInsets.zero, // Không có padding
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa search và section heading
                      TSectionHeading( // Tiêu đề section "Quốc Gia"
                        title: 'Quốc Gia', // Text tiêu đề
                        showActionButton: true, // Hiển thị nút action
                        onPressed: () {}, // Callback khi click nút action (chưa được implement)
                        textColor: TColors.black, // Màu chữ đen
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5), // Khoảng cách giữa tiêu đề và grid thương hiệu
                      
                      TGridLayout( // Widget layout dạng grid để hiển thị thương hiệu
                        itemCount: 4, // Số lượng thương hiệu (hardcode = 4)
                        mainAxisExtent: 80, // Chiều cao của mỗi item (80 pixels)
                        itemBuilder: (_, index ) { // Builder function để tạo widget cho mỗi item
                        return const TBrandCard(showBorder: false,); // Trả về BrandCard không có viền
                      },)
                    ],
                  ),
                ),
      
      
              bottom: TTabBar( // TabBar ở dưới SliverAppBar
                  /*
                  tabs: [ // Comment code cũ - danh sách tab hardcode
                Tab(child: Text('Nhật Bản')),
                Tab(child: Text('Viêt Nam')),
                Tab(child: Text('Hàn Quốc')),
                Tab(child: Text('Trung Quốc')),
                Tab(child: Text('Mỹ'))

              ]  */
                tabs: categories.map((category) => Tab(child: Text(category.name)) ).toList(), // Tạo danh sách tab từ danh sách categories (mỗi category là một tab)



              ),
              ),
            ];
          },
          body: TabBarView( // TabBarView - hiển thị nội dung tương ứng với tab được chọn
              children: [ // Danh sách các widget con (mỗi widget là nội dung của một tab)

                ...categories.map((category) => TCategoryTab(category: category)) // Spread operator để thêm tất cả TCategoryTab vào danh sách (mỗi category có một tab)
                /*
                TCategoryTab(), // Comment code cũ - các tab hardcode
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                TCategoryTab(),
                */

              ]

          ),
        ),
      ),
    );
  }
}
