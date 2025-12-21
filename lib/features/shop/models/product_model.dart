import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore - dùng cho DocumentSnapshot
import 'package:flutter/material.dart'; // Import Flutter Material (có thể không dùng trực tiếp)
import 'package:project/features/shop/models/product_atrribute.dart'; // Import ProductAttributeModel
import 'package:project/features/shop/models/product_variation.dart'; // Import ProductVariationModel
import 'brand_model.dart'; // Import BrandModel

class ProductModel { // Model đại diện cho thông tin sản phẩm
  String id; // ID của sản phẩm (thường là document ID từ Firestore)
  int stock; // Số lượng tồn kho
  String? sku; // Mã SKU của sản phẩm (có thể null)
  double price; // Giá gốc của sản phẩm
  String title; // Tên sản phẩm
  double salePrice; // Giá khuyến mãi
  String thumbnail; // URL hình ảnh thumbnail
  bool? isFeatured; // Có phải sản phẩm nổi bật không (có thể null)
  BrandModel? brand; // Thông tin thương hiệu (có thể null)
  String? description; // Mô tả sản phẩm (có thể null)
  String? categoryId; // ID danh mục sản phẩm (có thể null)
  List<String>? images; // Danh sách URL hình ảnh (có thể null)
  String productType; // Loại sản phẩm (ví dụ: 'simple', 'variable')
  List<ProductAttributeModel>? productAttributes; // Danh sách thuộc tính sản phẩm (có thể null)
  List<ProductVariationModel>? productVariations; // Danh sách biến thể sản phẩm (có thể null)

  // Constructor for ProductModel
  ProductModel({ // Constructor của ProductModel
    required this.id, // Tham số bắt buộc: id
    required this.title, // Tham số bắt buộc: title
    required this.stock, // Tham số bắt buộc: stock
    required this.price, // Tham số bắt buộc: price
    required this.thumbnail, // Tham số bắt buộc: thumbnail
    required this.productType, // Tham số bắt buộc: productType
    this.sku, // Tham số tùy chọn: sku
    this.salePrice = 0.0, // Tham số tùy chọn: salePrice (mặc định = 0.0)
    this.isFeatured, // Tham số tùy chọn: isFeatured
    this.brand, // Tham số tùy chọn: brand
    this.description, // Tham số tùy chọn: description
    this.categoryId, // Tham số tùy chọn: categoryId
    this.images, // Tham số tùy chọn: images
    this.productAttributes, // Tham số tùy chọn: productAttributes
    this.productVariations, // Tham số tùy chọn: productVariations
  });

  // Static method to create an empty ProductModel
  static ProductModel empty() => ProductModel( // Hàm tĩnh để tạo ProductModel rỗng
    id: '', // ID rỗng
    stock: 0, // Stock = 0
    price: 0.0, // Price = 0.0
    title: '', // Title rỗng
    thumbnail: '', // Thumbnail rỗng
    productType: '', // ProductType rỗng
  );

  // Method to convert ProductModel to Map (used when saving to Firestore)
  Map<String, dynamic> toJson() { // Hàm chuyển đổi ProductModel thành Map để lưu vào Firestore
    return { // Trả về Map với các key-value
      'Id': id, // Key 'Id' với giá trị id
      'Stock': stock, // Key 'Stock' với giá trị stock
      'SKU': sku, // Key 'SKU' với giá trị sku (có thể null)
      'Price': price, // Key 'Price' với giá trị price
      'Title': title, // Key 'Title' với giá trị title
      'SalePrice': salePrice, // Key 'SalePrice' với giá trị salePrice
      'Thumbnail': thumbnail, // Key 'Thumbnail' với giá trị thumbnail
      'IsFeatured': isFeatured, // Key 'IsFeatured' với giá trị isFeatured (có thể null)
      'Brand': brand?.toJson(), // Key 'Brand' với giá trị brand.toJson() (nếu brand không null)
      'Description': description, // Key 'Description' với giá trị description (có thể null)
      'CategoryId': categoryId, // Key 'CategoryId' với giá trị categoryId (có thể null)
      'Images': images, // Key 'Images' với giá trị images (có thể null)
      'ProductType': productType, // Key 'ProductType' với giá trị productType
      'ProductAttribute': productAttributes != null // Nếu productAttributes không null
          ? productAttributes!.map((e) => e.toJson()).toList() // Chuyển đổi từng attribute thành JSON và tạo list
          : [], // Nếu null thì trả về list rỗng
      'ProductVariations': productVariations != null // Nếu productVariations không null
          ? productVariations!.map((e) => e.toJson()).toList() // Chuyển đổi từng variation thành JSON và tạo list
          : [], // Nếu null thì trả về list rỗng
    };
  }

  // Factory constructor to create a ProductModel from Firestore DocumentSnapshot
  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) { // Factory constructor để tạo ProductModel từ Firestore DocumentSnapshot
    final data = document.data()!; // Lấy dữ liệu từ document (dùng ! vì đã kiểm tra document tồn tại)
    return ProductModel( // Trả về ProductModel mới
      id: document.id, // Lấy id từ document ID
      stock: data['Stock'] ?? 0, // Lấy Stock từ data, nếu null thì dùng 0
      sku: data['SKU'], // Lấy SKU từ data (có thể null)
      price: (data['Price'] as num).toDouble(), // Lấy Price từ data và chuyển thành double
      title: data['Title'] ?? '', // Lấy Title từ data, nếu null thì dùng chuỗi rỗng
      salePrice: (data['SalePrice'] as num?)?.toDouble() ?? 0.0, // Lấy SalePrice từ data, chuyển thành double, nếu null thì dùng 0.0
      thumbnail: data['Thumbnail'] ?? '', // Lấy Thumbnail từ data, nếu null thì dùng chuỗi rỗng
      isFeatured: data['IsFeatured'], // Lấy IsFeatured từ data (có thể null)
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null, // Nếu Brand không null thì tạo BrandModel từ JSON, ngược lại null
      description: data['Description'], // Lấy Description từ data (có thể null)
      categoryId: data['CategoryId']?.toString(), // Lấy CategoryId từ data và chuyển thành String (có thể null)
      images: data['Images'] != null ? List<String>.from(data['Images']) : [], // Nếu Images không null thì tạo list String, ngược lại list rỗng
      productType: data['ProductType'] ?? '', // Lấy ProductType từ data, nếu null thì dùng chuỗi rỗng
      productAttributes: data['ProductAttribute'] != null // Nếu ProductAttribute không null
          ? (data['ProductAttribute'] as List) // Ép kiểu thành List
          .map((e) => ProductAttributeModel.fromJson(e)) // Chuyển đổi từng phần tử thành ProductAttributeModel
          .toList() // Tạo list
          : [], // Nếu null thì trả về list rỗng
      productVariations: data['ProductVariations'] != null // Nếu ProductVariations không null
          ? (data['ProductVariations'] as List) // Ép kiểu thành List
          .map((e) => ProductVariationModel.fromJson(e)) // Chuyển đổi từng phần tử thành ProductVariationModel
          .toList() // Tạo list
          : [], // Nếu null thì trả về list rỗng
    );
  }

}
