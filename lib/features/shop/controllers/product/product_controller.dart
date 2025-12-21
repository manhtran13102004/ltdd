import 'dart:async'; // Import thư viện async (có thể không dùng trực tiếp)
import 'package:get/get.dart'; // Import GetX - dùng cho state management và snackbar
import '../../../../data/repositories/banners/banner_repository.dart'; // Import BannerRepository (có thể không dùng trực tiếp)
import '../../../../data/repositories/product/product_repository.dart'; // Import ProductRepository
import '../../../../utils/constants/enums.dart'; // Import enums (ProductType)
import '../../models/banner_model.dart'; // Import BannerModel (có thể không dùng trực tiếp)
import '../../models/product_model.dart'; // Import ProductModel

class ProductController extends GetxController { // Controller xử lý logic sản phẩm - kế thừa GetxController
  static ProductController get instance => Get.find(); // Getter để lấy instance của ProductController từ GetX dependency injection
  final isLoading = false.obs; // Observable để quản lý trạng thái loading
  final productRepository = Get.put(ProductRepository()); // Khởi tạo và đăng ký ProductRepository vào GetX dependency injection

  RxList<ProductModel> featuredProducts = <ProductModel>[].obs; // Observable list chứa các sản phẩm nổi bật

  @override
  void onInit() { // Hàm được gọi khi controller được khởi tạo
    super.onInit(); // Gọi hàm onInit của class cha
    fetchCategories();  // Gọi fetchCategories để tải dữ liệu sản phẩm (tên hàm có thể sai, nên là fetchProducts)
  }

  Future<void> fetchCategories() async { // Hàm lấy danh sách sản phẩm nổi bật từ repository (tên hàm có thể sai, nên là fetchProducts)
    try { // Bắt đầu khối try-catch để xử lý lỗi
      isLoading.value = true; // Đặt trạng thái loading = true
      final products = await productRepository.getFeaturedProducts(); // Lấy các sản phẩm nổi bật từ repository
      featuredProducts.assignAll(products); // Gán các sản phẩm vào featuredProducts

      // Kiểm tra null trước khi truy cập vào productAttributes
      if (products != null && products.isNotEmpty) { // Nếu có sản phẩm
        for (var product in products) { // Lặp qua từng sản phẩm
          print('danh sách thuộc tính: ${product.productAttributes ?? 'Không có thuộc tính'}'); // In danh sách thuộc tính ra console (để debug)
        }
      } else { // Nếu không có sản phẩm
        print('Danh sách sản phẩm trống hoặc null'); // In thông báo ra console
      }
    } catch (e) { // Bắt lỗi nếu có
      Get.snackbar('Error', 'Error fetching categories: $e'); // Hiển thị snackbar thông báo lỗi (comment có thể sai, nên là 'Error fetching products')
    } finally { // Khối finally luôn được thực thi
      isLoading.value = false; // Đặt trạng thái loading = false (dù thành công hay thất bại)
    }
  }
  String getProductPrice(ProductModel product) { // Hàm lấy giá sản phẩm (có thể là khoảng giá nếu có nhiều biến thể)
    double smallestPrice = double.infinity; // Giá nhỏ nhất (khởi tạo = infinity)
    double largestPrice = 0; // Giá lớn nhất (khởi tạo = 0)

    if (product.productType == ProductType.single.toString()) { // Nếu là sản phẩm đơn giản (không có biến thể)
      return (product.salePrice > 0 ? product.salePrice : product.price) // Nếu có giá khuyến mãi thì dùng salePrice, ngược lại dùng price
          .toStringAsFixed(0); // Chuyển thành string với 0 chữ số thập phân
    } else { // Nếu là sản phẩm có biến thể
      for (var variation in product.productVariations!) { // Lặp qua từng biến thể
        double priceToConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price; // Lấy giá khuyến mãi nếu có, ngược lại lấy giá gốc

        if (priceToConsider < smallestPrice) { // Nếu giá hiện tại nhỏ hơn giá nhỏ nhất
          smallestPrice = priceToConsider; // Cập nhật giá nhỏ nhất
        }
        if (priceToConsider > largestPrice) { // Nếu giá hiện tại lớn hơn giá lớn nhất
          largestPrice = priceToConsider; // Cập nhật giá lớn nhất
        }
      }

      if (smallestPrice == largestPrice) { // Nếu giá nhỏ nhất = giá lớn nhất (tất cả biến thể có cùng giá)
        return largestPrice.toStringAsFixed(0); // Trả về giá duy nhất
      } else { // Nếu có khoảng giá
        return '${smallestPrice.toStringAsFixed(0)}.000 - ${largestPrice.toStringAsFixed(0)}'; // Trả về khoảng giá (có thể có lỗi format, nên là '${smallestPrice.toStringAsFixed(0)} - ${largestPrice.toStringAsFixed(0)}')
      }
    }
  }
  String getProductLowesPrice(ProductModel product) { // Hàm lấy giá thấp nhất của sản phẩm
    double smallestPrice = double.infinity; // Giá nhỏ nhất (khởi tạo = infinity)
    double largestPrice = 0; // Giá lớn nhất (khởi tạo = 0, có thể không cần)

    if (product.productType == ProductType.single.toString()) { // Nếu là sản phẩm đơn giản (không có biến thể)
      return (product.salePrice > 0 ? product.salePrice : product.price) // Nếu có giá khuyến mãi thì dùng salePrice, ngược lại dùng price
          .toStringAsFixed(0); // Chuyển thành string với 0 chữ số thập phân
    } else { // Nếu là sản phẩm có biến thể
      for (var variation in product.productVariations!) { // Lặp qua từng biến thể
        double priceToConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price; // Lấy giá khuyến mãi nếu có, ngược lại lấy giá gốc

        if (priceToConsider < smallestPrice) { // Nếu giá hiện tại nhỏ hơn giá nhỏ nhất
          smallestPrice = priceToConsider; // Cập nhật giá nhỏ nhất
        }
        if (priceToConsider > largestPrice) { // Nếu giá hiện tại lớn hơn giá lớn nhất
          largestPrice = priceToConsider; // Cập nhật giá lớn nhất
        }
      }

      if (smallestPrice == largestPrice) { // Nếu giá nhỏ nhất = giá lớn nhất (tất cả biến thể có cùng giá)
        return largestPrice.toStringAsFixed(0); // Trả về giá duy nhất
      } else { // Nếu có khoảng giá
        return smallestPrice.toStringAsFixed(0) ; // Trả về giá nhỏ nhất
      }
    }
  }



  String? calculatorSalePercentage(double originalPrice, double? salePrice){ // Hàm tính phần trăm giảm giá
    if(salePrice == null || salePrice <= 0.0) return null; // Nếu không có giá khuyến mãi hoặc giá khuyến mãi <= 0 thì trả về null

    if(originalPrice <= 0) return null; // Nếu giá gốc <= 0 thì trả về null

    double percentage = ((originalPrice -salePrice) / originalPrice)*100; // Tính phần trăm giảm giá: ((giá gốc - giá khuyến mãi) / giá gốc) * 100
    return percentage.toStringAsFixed(0); // Trả về phần trăm với 0 chữ số thập phân
  }

   String getProductStockSatus(int stock){ // Hàm lấy trạng thái tồn kho (có typo: StockSatus thay vì StockStatus)
    return stock > 0 ? 'Còn hàng' : 'Hết hàng'; // Nếu stock > 0 thì trả về 'Còn hàng', ngược lại 'Hết hàng'
   }





}
