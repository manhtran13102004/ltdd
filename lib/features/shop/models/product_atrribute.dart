// File định nghĩa model cho thuộc tính sản phẩm (ví dụ: Màu sắc, Kích thước)


class ProductAttributeModel { // Model đại diện cho thuộc tính sản phẩm (ví dụ: Màu sắc, Kích thước)
  String name; // Tên thuộc tính (ví dụ: "Màu sắc", "Kích thước")
  final List<String> values; // Danh sách giá trị của thuộc tính (ví dụ: ["Đỏ", "Xanh", "Vàng"] cho Màu sắc)

  ProductAttributeModel({this.name = '', this.values = const []}); // Constructor với giá trị mặc định: name = chuỗi rỗng, values = list rỗng

  Map<String, dynamic> toJson() { // Hàm chuyển đổi ProductAttributeModel thành Map để lưu vào Firestore
    return {'Name': name, 'Values': values}; // Trả về Map với key 'Name' và 'Values'
  }

  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) { // Factory constructor để tạo ProductAttributeModel từ Map JSON
    if (document.isEmpty) return ProductAttributeModel(); // Nếu document rỗng thì trả về ProductAttributeModel rỗng

    return ProductAttributeModel( // Trả về ProductAttributeModel mới
      name: document.containsKey('Name') ? document['Name'] : '', // Lấy Name từ document nếu có, ngược lại dùng chuỗi rỗng
      values: List<String>.from(document['Values'] ?? []), // Lấy Values từ document và chuyển thành List<String>, nếu null thì dùng list rỗng
    );
  }
}
