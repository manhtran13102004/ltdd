// File định nghĩa model cho thương hiệu (brand)

class BrandModel { // Model đại diện cho thông tin thương hiệu
  String id; // ID của thương hiệu (thường là document ID từ Firestore)
  String name; // Tên thương hiệu
  String image; // URL hình ảnh logo thương hiệu
  bool? isFeatured; // Có phải thương hiệu nổi bật không (có thể null)
  int? productsCount; // Số lượng sản phẩm của thương hiệu (có thể null)

  BrandModel({ // Constructor của BrandModel
    required this.id, // Tham số bắt buộc: id
    required this.name, // Tham số bắt buộc: name
    required this.image, // Tham số bắt buộc: image
    this.isFeatured, // Tham số tùy chọn: isFeatured
    this.productsCount, // Tham số tùy chọn: productsCount
  });

  // Static method to return an empty instance of BrandModel
  static BrandModel empty() => BrandModel( // Hàm tĩnh để tạo BrandModel rỗng
    id: '', // ID rỗng
    name: '', // Name rỗng
    image: '', // Image rỗng

  );

  // Method to convert the object to a JSON-compatible map
  Map<String, dynamic> toJson() { // Hàm chuyển đổi BrandModel thành Map để lưu vào Firestore
    return { // Trả về Map với các key-value
      'Id': id, // Key 'Id' với giá trị id
      'Name': name, // Key 'Name' với giá trị name
      'Image': image, // Key 'Image' với giá trị image
      'IsFeatured': isFeatured, // Key 'IsFeatured' với giá trị isFeatured (có thể null)
      'ProductsCount': productsCount, // Key 'ProductsCount' với giá trị productsCount (có thể null)
    };
  }

  // Factory constructor to create an instance from JSON data
  factory BrandModel.fromJson(Map<String, dynamic> document) { // Factory constructor để tạo BrandModel từ Map JSON
    return BrandModel( // Trả về BrandModel mới
      id: document['Id'] ?? '', // Lấy Id từ document, nếu null thì dùng chuỗi rỗng
      name: document['Name'] ?? '', // Lấy Name từ document, nếu null thì dùng chuỗi rỗng
      image: document['Image'] ?? '', // Lấy Image từ document, nếu null thì dùng chuỗi rỗng
      isFeatured: document['IsFeatured'] ?? false, // Lấy IsFeatured từ document, nếu null thì dùng false
      productsCount: document['ProductsCount'] ?? 0, // Lấy ProductsCount từ document, nếu null thì dùng 0
    );
  }
}
