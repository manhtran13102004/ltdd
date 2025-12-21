import 'dart:async'; // Import thư viện async (có thể không dùng trực tiếp)
import 'package:get/get.dart'; // Import GetX - dùng cho state management
import 'package:project/features/shop/controllers/product/product_controller.dart'; // Import ProductController (có thể không dùng trực tiếp)
import '../../../../data/repositories/banners/banner_repository.dart'; // Import BannerRepository (có thể không dùng trực tiếp)
import '../../../../data/repositories/product/product_repository.dart'; // Import ProductRepository (có thể không dùng trực tiếp)
import '../../../../utils/constants/enums.dart'; // Import enums (có thể không dùng trực tiếp)
import '../../models/banner_model.dart'; // Import BannerModel (có thể không dùng trực tiếp)
import '../../models/product_model.dart'; // Import ProductModel
import '../../models/product_variation.dart'; // Import ProductVariationModel
import 'images_controller.dart'; // Import ImagesController

class VariationController extends GetxController { // Controller xử lý logic biến thể sản phẩm - kế thừa GetxController
 static VariationController get instance => Get.find(); // Getter để lấy instance của VariationController từ GetX dependency injection

 RxMap<String, dynamic> selectedAttributes = <String, dynamic>{}.obs; // Observable map lưu các thuộc tính đã chọn (ví dụ: {"Màu sắc": "Đỏ", "Kích thước": "M"})
 RxString variationStockStatus = ''.obs;  // Observable lưu trạng thái kho của biến thể hiện tại (ví dụ: "Còn hàng", "Hết hàng")
 Rx<ProductVariationModel> selectedVariation = ProductVariationModel.empty().obs; // Observable lưu biến thể đang được chọn



 // Hàm khi chọn thuộc tính
 void onAttributeSelected(ProductModel product, String attributeName, dynamic attributeValue) { // Hàm xử lý khi user chọn một thuộc tính (ví dụ: chọn màu "Đỏ")
  selectedAttributes[attributeName] = attributeValue; // Cập nhật selectedAttributes với thuộc tính vừa chọn

  // Tìm biến thể phù hợp với thuộc tính đã chọn
  final matchingVariation = product.productVariations!.firstWhere( // Tìm biến thể đầu tiên thỏa mãn điều kiện
       (variation) => _isSameAttributeValues(variation.attributeValues, selectedAttributes), // Kiểm tra attributeValues của variation có khớp với selectedAttributes không
   orElse: () => ProductVariationModel.empty(), // Nếu không tìm thấy thì trả về ProductVariationModel rỗng
  );

  if (matchingVariation.image.isNotEmpty) { // Nếu biến thể có hình ảnh
   ImagesController.instance.selectedProductImage.value = matchingVariation.image; // Cập nhật selectedProductImage với hình ảnh của biến thể
  }

  selectedVariation.value = matchingVariation; // Cập nhật selectedVariation với biến thể vừa tìm được

  // Cập nhật trạng thái kho sau khi chọn thuộc tính
  getProductVariationStockStatus(); // Gọi hàm để cập nhật trạng thái kho
 }

 // Kiểm tra các thuộc tính có giống nhau không
 bool _isSameAttributeValues(Map<String, dynamic> variationAttributes, Map<String, dynamic> selectedAttributes) { // Hàm private để kiểm tra 2 map thuộc tính có giống nhau không
  if (variationAttributes.length != selectedAttributes.length) return false; // Nếu số lượng key khác nhau thì trả về false

  for (final key in variationAttributes.keys) { // Lặp qua từng key trong variationAttributes
   if (variationAttributes[key] != selectedAttributes[key]) return false; // Nếu giá trị của key không khớp thì trả về false
  }
  return true; // Nếu tất cả key-value đều khớp thì trả về true
 }

 // Lấy các giá trị có sẵn của thuộc tính trong biến thể
 Set<String?> getAttributesAvailabilityInVariation(List<ProductVariationModel> variations, String attributeName) { // Hàm lấy các giá trị có sẵn của một thuộc tính (ví dụ: các màu sắc còn hàng)
  final availableVariationAttributeValues = variations // Lọc các biến thể
      .where((variation) => // Điều kiện lọc
  variation.attributeValues[attributeName] != null && // Thuộc tính phải có giá trị
      variation.attributeValues[attributeName]!.isNotEmpty && // Giá trị không rỗng
      variation.stock > 0) // Còn hàng (stock > 0)
      .map((variation) => variation.attributeValues[attributeName]) // Lấy giá trị của thuộc tính
      .toSet(); // Chuyển thành Set để loại bỏ trùng lặp

  return availableVariationAttributeValues; // Trả về Set các giá trị có sẵn
 }

 // Lấy giá của biến thể
 String getVariationPrice() { // Hàm lấy giá của biến thể đang được chọn
  double salePrice = selectedVariation.value.salePrice; // Lấy giá khuyến mãi
  double price = selectedVariation.value.price; // Lấy giá gốc

  return (salePrice > 0 ? salePrice : price).toStringAsFixed(0); // Nếu có giá khuyến mãi thì trả về salePrice, ngược lại trả về price (format với 0 chữ số thập phân)
 }

 // Cập nhật trạng thái kho của biến thể hiện tại
 void getProductVariationStockStatus() { // Hàm cập nhật trạng thái kho
  if (selectedVariation.value.id.isEmpty) { // Nếu không có biến thể được chọn
   variationStockStatus.value = 'Không có thông tin'; // Đặt trạng thái = "Không có thông tin"
  } else { // Nếu có biến thể được chọn
   variationStockStatus.value = selectedVariation.value.stock > 0 ? 'Còn hàng' : 'Hết hàng'; // Nếu stock > 0 thì "Còn hàng", ngược lại "Hết hàng"
  }
 }

 // Đặt lại các thuộc tính đã chọn
 void resetSelectedAttributes() { // Hàm reset tất cả các thuộc tính đã chọn
  selectedAttributes.clear(); // Xóa tất cả thuộc tính đã chọn
  variationStockStatus.value = ''; // Đặt trạng thái kho = chuỗi rỗng
  selectedVariation.value = ProductVariationModel.empty(); // Đặt selectedVariation = ProductVariationModel rỗng
 }


}
