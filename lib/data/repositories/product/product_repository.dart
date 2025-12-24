// lib/data/repositories/product/product_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../features/shop/models/product_model.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'Products';

  // Lấy tất cả sản phẩm (dùng cho filter category/brand/search)
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _firestore.collection(_collectionPath).get();
      return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
    } catch (e) {
      print('Lỗi khi lấy tất cả sản phẩm: $e');
      return [];
    }
  }

  // Lấy sản phẩm nổi bật (có thể giữ nguyên hoặc thêm điều kiện isFeatured: true)
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _firestore
          .collection(_collectionPath)
          .where('IsFeatured', isEqualTo: true)
          .limit(8) // Giới hạn để nhanh hơn
          .get();

      return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
    } catch (e) {
      Get.snackbar('Lỗi', 'Không tải được sản phẩm nổi bật: $e');
      return [];
    }
  }


  Future<List<ProductModel>> getProductsByBrandId(String brandId) async {
    try {
      final snapshot = await _firestore
          .collection('Products')
          .where('Brand.Id', isEqualTo: brandId)  // ← CHỈ SỬA DÒNG NÀY THÔI!
          .get();

      return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
    } catch (e) {
      print('Lỗi khi lọc sản phẩm theo chi nhánh $brandId: $e');
      return [];
    }
  }

  // MỚI: Lấy sản phẩm theo categoryId (nếu chưa có thì thêm luôn)
  Future<List<ProductModel>> getProductsByCategoryId(String categoryId) async {
    try {
      final snapshot = await _firestore
          .collection(_collectionPath)
          .where('CategoryId', isEqualTo: categoryId)
          .get();

      return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
    } catch (e) {
      print('Lỗi khi lọc sản phẩm theo danh mục $categoryId: $e');
      return [];
    }
  }
}