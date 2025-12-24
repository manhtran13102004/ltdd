import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/features/shop/models/brand_model.dart';
import 'package:project/features/shop/models/product_model.dart';
import 'package:project/features/shop/controllers/product/product_controller.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final isLoading = false.obs;

  final productController = Get.find<ProductController>();

  @override
  void onInit() {
    super.onInit();
    fetchAllBrands();
  }

  Future<void> fetchAllBrands() async {
    try {
      isLoading.value = true;
      final snapshot = await FirebaseFirestore.instance.collection('Brands').get();
      allBrands.assignAll(snapshot.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList());
    } catch (e) {
      Get.snackbar('Lỗi', 'Không load được brands: $e');
    } finally {
      isLoading.value = false;
    }
  }
}