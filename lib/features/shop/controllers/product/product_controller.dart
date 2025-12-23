import 'dart:async';
import 'package:get/get.dart';
import '../../../../data/repositories/banners/banner_repository.dart';
import '../../../../data/repositories/product/product_repository.dart';
import '../../../../utils/constants/enums.dart';
import '../../models/banner_model.dart';
import '../../models/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());

  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  // THÊM MỚI: Danh sách tất cả sản phẩm để filter theo category
  RxList<ProductModel> allProducts = <ProductModel>[].obs;

  // THÊM DÒNG NÀY ĐỂ SEARCH REALTIME
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();        // Giữ nguyên hàm cũ của mày
    fetchAllProducts();       // THÊM: Load tất cả sản phẩm để filter category
  }

  // GIỮ NGUYÊN HOÀN TOÀN hàm cũ của mày (không sửa tên, không sửa logic)
  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final products = await productRepository.getFeaturedProducts();
      featuredProducts.assignAll(products);

      if (products != null && products.isNotEmpty) {
        for (var product in products) {
          print('danh sách thuộc tính: ${product.productAttributes ?? 'Không có thuộc tính'}');
        }
      } else {
        print('Danh sách sản phẩm trống hoặc null');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error fetching categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // THÊM MỚI: Load toàn bộ sản phẩm từ Firebase (không ảnh hưởng gì đến hàm cũ)
  Future<void> fetchAllProducts() async {
    try {
      // Giả sử repository của mày có hàm getAllProducts()
      // Nếu chưa có → xem note cuối cùng của tao
      final products = await productRepository.getAllProducts();
      allProducts.assignAll(products);
    } catch (e) {
      print('Lỗi tải tất cả sản phẩm: $e');
      allProducts.clear();
    }
  }

  // THÊM MỚI: Hàm filter sản phẩm theo categoryId – dùng cho SubCategoriesScreen
  List<ProductModel> getProductsForCategory(String categoryId) {
    return allProducts.where((product) => product.categoryId == categoryId).toList();
  }

  // GIỮ NGUYÊN HOÀN TOÀN các hàm cũ của mày (không sửa tên, không sửa logic)
  String getProductPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0;

    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toStringAsFixed(0);
    } else {
      for (var variation in product.productVariations!) {
        double priceToConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      if (smallestPrice == largestPrice) {
        return largestPrice.toStringAsFixed(0);
      } else {
        return '${smallestPrice.toStringAsFixed(0)}.000 - ${largestPrice.toStringAsFixed(0)}';
      }
    }
  }

  String getProductLowesPrice(ProductModel product) {
    double smallestPrice = double.infinity;
    double largestPrice = 0;

    if (product.productType == ProductType.single.toString()) {
      return (product.salePrice > 0 ? product.salePrice : product.price)
          .toStringAsFixed(0);
    } else {
      for (var variation in product.productVariations!) {
        double priceToConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        if (priceToConsider < smallestPrice) {
          smallestPrice = priceToConsider;
        }
        if (priceToConsider > largestPrice) {
          largestPrice = priceToConsider;
        }
      }

      if (smallestPrice == largestPrice) {
        return largestPrice.toStringAsFixed(0);
      } else {
        return smallestPrice.toStringAsFixed(0);
      }
    }
  }

  String? calculatorSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  String getProductStockSatus(int stock) {
    return stock > 0 ? 'Còn hàng' : 'Hết hàng';
  }
}