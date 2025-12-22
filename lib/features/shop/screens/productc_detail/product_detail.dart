import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho state management và navigation
import 'package:get/get_core/src/get_main.dart'; // Import GetX core (có thể không cần thiết)
import 'package:iconsax/iconsax.dart'; // Import icon pack Iconsax
import 'package:project/common/widgets/images/t_rounded_image.dart'; // Import widget hình ảnh bo góc (có thể không dùng trực tiếp)
import 'package:project/features/shop/screens/productc_detail/widgets/bottom_add_to_cart_widget.dart'; // Import widget nút thêm vào giỏ hàng ở dưới cùng
import 'package:project/features/shop/screens/productc_detail/widgets/product_attributes.dart'; // Import widget hiển thị thuộc tính sản phẩm (màu sắc, kích thước...)
import 'package:project/features/shop/screens/productc_detail/widgets/product_detail_image_slider.dart'; // Import widget slider hình ảnh sản phẩm
import 'package:project/features/shop/screens/productc_detail/widgets/product_meta_data.dart'; // Import widget hiển thị thông tin meta của sản phẩm (tên, giá, thương hiệu...)
import 'package:project/features/shop/screens/productc_detail/widgets/rating_share_widget.dart'; // Import widget hiển thị đánh giá và nút chia sẻ
import 'package:readmore/readmore.dart'; // Import thư viện ReadMore - hiển thị text có thể mở rộng/thu gọn

import '../../../../common/widgets/appbar/appbar.dart'; // Import widget AppBar chung (có thể không dùng trực tiếp)
import '../../../../common/widgets/curved_edges/curved_edges_widget.dart'; // Import widget curved edges (có thể không dùng trực tiếp)
import '../../../../common/widgets/icons/t_circular_icon.dart'; // Import widget icon tròn (có thể không dùng trực tiếp)
import '../../../../common/widgets/texts/section_heading.dart'; // Import widget tiêu đề section
import '../../../../common/widgets/texts/section_heading.dart'; // Import trùng lặp (có thể xóa)
import '../../../../utils/constants/colors.dart'; // Import màu sắc chuẩn
import '../../../../utils/constants/enums.dart'; // Import enums (có thể không dùng trực tiếp)
import '../../../../utils/constants/image_strings.dart'; // Import đường dẫn hình ảnh chuẩn (có thể không dùng trực tiếp)
import '../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../../../utils/helpers/helper_functions.dart'; // Import các hàm helper
import '../../controllers/product/variation_controller.dart'; // Import controller xử lý logic biến thể sản phẩm
import '../../models/product_model.dart'; // Import ProductModel

class ProductDetail extends StatelessWidget { // Màn hình chi tiết sản phẩm - StatelessWidget
  const ProductDetail({super.key, required this.product}); // Constructor với product parameter bắt buộc
  final ProductModel product; // Biến lưu thông tin sản phẩm cần hiển thị

  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    final isDarkMode = THelperFunctions.isDarkMode(context); // Kiểm tra chế độ dark mode (có thể không dùng trực tiếp)

    // Sử dụng WidgetsBinding.addPostFrameCallback để gọi resetSelectedAttributes sau khi build hoàn tất
    WidgetsBinding.instance.addPostFrameCallback((_) { // Gọi callback sau khi frame hiện tại được render xong
      final controller = Get.put(VariationController()); // Khởi tạo và đăng ký VariationController vào GetX dependency injection
      controller.resetSelectedAttributes(); // Reset các thuộc tính đã chọn (màu sắc, kích thước...) về trạng thái ban đầu
    });

    return Scaffold( // Scaffold - widget cơ bản nhất của Material Design
      bottomNavigationBar: TButtonAddToCart(product: product), // Bottom navigation bar chứa nút thêm vào giỏ hàng
      body: SingleChildScrollView( // SingleChildScrollView - cho phép cuộn nội dung
        child: Column( // Column - sắp xếp các widget theo chiều dọc
          children: [ // Danh sách các widget con
            TProductimageSlider(product: product), // Widget slider hiển thị hình ảnh sản phẩm
            Padding( // Padding xung quanh nội dung chi tiết
              padding: const EdgeInsets.only( // Padding chỉ ở các cạnh được chỉ định
                  right: TSizes.defaultSpace, // Padding bên phải
                  left: TSizes.defaultSpace, // Padding bên trái
                  bottom: TSizes.defaultSpace), // Padding dưới cùng
              child: Column( // Column chứa nội dung chi tiết
                children: [ // Danh sách các widget con
                  const TRatingAndShare(), // Widget hiển thị đánh giá (sao) và nút chia sẻ
                  TProductMetaData(product: product), // Widget hiển thị thông tin meta (tên, giá, thương hiệu, mô tả ngắn...)
                  const SizedBox(height: TSizes.spaceBtwItems ), // Khoảng cách giữa meta data và attributes

                  TProductAttributes( // Widget hiển thị thuộc tính sản phẩm (màu sắc, kích thước...)
                    product: product, // Truyền product vào widget
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa attributes và nút Check Out
                  SizedBox( // SizedBox để giới hạn kích thước nút
                    width: double.infinity, // Chiều rộng bằng toàn bộ màn hình
                    child: ElevatedButton( // Nút "Check Out" (có thể không cần thiết vì đã có bottom navigation bar)
                      onPressed: () {}, // Callback khi click (chưa được implement)
                      style: ElevatedButton.styleFrom( // Định nghĩa style cho nút
                        backgroundColor: TColors.primary, // Màu nền primary
                        side: const BorderSide(color: TColors.primary), // Viền màu primary
                      ),
                      child: const Text('Check Out'), // Text hiển thị "Check Out"
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections), // Khoảng cách giữa nút Check Out và section mô tả
                  const TSectionHeading( // Tiêu đề section "Mô tả"
                    title: 'Mô tả ', // Text tiêu đề
                    textColor: TColors.black, // Màu chữ đen
                    showActionButton: false, // Không hiển thị nút action
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách giữa tiêu đề và nội dung mô tả
                  const ReadMoreText( // Widget hiển thị text có thể mở rộng/thu gọn
                    'Sản phẩm chất lượng cao, hàng nhập khẩu chính hãng.', // Nội dung mô tả (hardcode, nên dùng product.description)
                    trimLines: 2, // Số dòng hiển thị khi thu gọn (2 dòng)
                    trimMode: TrimMode.Line, // Chế độ trim theo dòng
                    trimCollapsedText: 'Xem thêm', // Text hiển thị khi đang thu gọn
                    trimExpandedText: ' Rút gọn', // Text hiển thị khi đang mở rộng
                    textAlign: TextAlign.justify, // Căn đều text
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800), // Style cho text "Xem thêm"
                    lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800), // Style cho text "Rút gọn"
                  ),
                  const Divider(), // Đường kẻ ngang phân cách
                  const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách giữa divider và section bình luận
                  Row( // Row để sắp xếp tiêu đề và icon
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Căn các widget con: tiêu đề bên trái, icon bên phải
                    children: [ // Danh sách các widget con
                      const TSectionHeading( // Tiêu đề section "Bình Luận"
                        title: 'Bình Luận (150) ', // Text tiêu đề với số lượng bình luận (hardcode, nên lấy từ data)
                        textColor: TColors.black, // Màu chữ đen
                        showActionButton: false, // Không hiển thị nút action
                      ),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_right)) // Icon mũi tên phải - khi click sẽ xem tất cả bình luận (chưa được implement)
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems), // Khoảng cách cuối cùng
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



