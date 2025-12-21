// File định nghĩa model cho biến thể sản phẩm (ví dụ: Áo thun màu đỏ size M, Áo thun màu xanh size L)

class ProductVariationModel { // Model đại diện cho biến thể sản phẩm
  final String id; // ID của biến thể
  String sku; // Mã SKU của biến thể
  String image; // URL hình ảnh của biến thể
  double price; // Giá gốc của biến thể
  String? description;  // Mô tả biến thể (có thể null)
  double salePrice; // Giá khuyến mãi của biến thể
  int stock; // Số lượng tồn kho của biến thể
  Map<String, String> attributeValues; // Map chứa các giá trị thuộc tính (ví dụ: {"Màu sắc": "Đỏ", "Kích thước": "M"})

  ProductVariationModel({ // Constructor của ProductVariationModel
    required this.id, // Tham số bắt buộc: id
    this.sku = '', // Tham số tùy chọn: sku (mặc định = chuỗi rỗng)
    this.image = '', // Tham số tùy chọn: image (mặc định = chuỗi rỗng)
    this.description,  // Tham số tùy chọn: description (có thể null)
    this.price = 0.0, // Tham số tùy chọn: price (mặc định = 0.0)
    this.salePrice = 0.0, // Tham số tùy chọn: salePrice (mặc định = 0.0)
    this.stock = 0, // Tham số tùy chọn: stock (mặc định = 0)
    required this.attributeValues, // Tham số bắt buộc: attributeValues
  });

  static ProductVariationModel empty() => ProductVariationModel(id: '', attributeValues: {}); // Hàm tĩnh để tạo ProductVariationModel rỗng

  Map<String, dynamic> toJson() {  // Hàm chuyển đổi ProductVariationModel thành Map để lưu vào Firestore
    return { // Trả về Map với các key-value
      'Id': id, // Key 'Id' với giá trị id
      'SKU': sku, // Key 'SKU' với giá trị sku
      'Image': image, // Key 'Image' với giá trị image
      'Price': price, // Key 'Price' với giá trị price
      'Description': description, // Key 'Description' với giá trị description (có thể null)
      'SalePrice': salePrice, // Key 'SalePrice' với giá trị salePrice
      'Stock': stock, // Key 'Stock' với giá trị stock
      'AttributeValues': attributeValues, // Key 'AttributeValues' với giá trị attributeValues
    };
  }

  factory ProductVariationModel.fromJson(Map<String, dynamic> document) { // Factory constructor để tạo ProductVariationModel từ Map JSON
    return ProductVariationModel( // Trả về ProductVariationModel mới
      id: document['Id'] ?? '', // Lấy Id từ document, nếu null thì dùng chuỗi rỗng
      sku: document['SKU'] ?? '', // Lấy SKU từ document, nếu null thì dùng chuỗi rỗng
      image: document['Image'] ?? '', // Lấy Image từ document, nếu null thì dùng chuỗi rỗng
      description: document['Description'],  // Lấy Description từ document (có thể null, không cần dùng ??)
      price: (document['Price'] ?? 0.0).toDouble(), // Lấy Price từ document, nếu null thì dùng 0.0 và chuyển thành double
      salePrice: (document['SalePrice'] ?? 0.0).toDouble(), // Lấy SalePrice từ document, nếu null thì dùng 0.0 và chuyển thành double
      stock: document['Stock'] ?? 0, // Lấy Stock từ document, nếu null thì dùng 0
      attributeValues: Map<String, String>.from(document['AttributeValues'] ?? {}), // Lấy AttributeValues từ document và chuyển thành Map<String, String>, nếu null thì dùng map rỗng
    );
  }
}
