import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore - dùng cho DocumentSnapshot

class UserModel { // Model đại diện cho thông tin user
  final String id; // ID của user (thường là document ID từ Firestore)

  final String firstName; // Họ của user
  final String lastName; // Tên của user
  final String username; // Tên đăng nhập của user
  final String email; // Email của user
  final String password; // Mật khẩu của user (nên được mã hóa trong thực tế)
  final String phoneNo; // Số điện thoại của user
  final String gender; // Giới tính của user
  final String dateOfBirth; // Ngày sinh của user

  UserModel( // Constructor của UserModel
      {   required this.id, // Tham số bắt buộc: id
        required this.gender, // Tham số bắt buộc: gender
      required this.firstName, // Tham số bắt buộc: firstName
      required this.lastName, // Tham số bắt buộc: lastName
      required this.username, // Tham số bắt buộc: username
      required this.email, // Tham số bắt buộc: email
      required this.password, // Tham số bắt buộc: password
      required this.phoneNo, // Tham số bắt buộc: phoneNo
        required this.dateOfBirth,}); // Tham số bắt buộc: dateOfBirth

  Map<String, dynamic> toJson() { // Hàm chuyển đổi UserModel thành Map để lưu vào Firestore
    return { // Trả về Map với các key-value
      'FirstName': firstName, // Key 'FirstName' với giá trị firstName
      'LastName': lastName, // Key 'LastName' với giá trị lastName
      'Username': username, // Key 'Username' với giá trị username
      'Email': email, // Key 'Email' với giá trị email
      'Password': password, // Key 'Password' với giá trị password
      'PhoneNo': phoneNo, // Key 'PhoneNo' với giá trị phoneNo
      'Gender' :gender, // Key 'Gender' với giá trị gender
      'DateOfBirth': dateOfBirth // Key 'DateOfBirth' với giá trị dateOfBirth
    };
  }
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) { // Factory constructor để tạo UserModel từ Firestore DocumentSnapshot
    final data =doc.data()! ; // Lấy dữ liệu từ document (dùng ! vì đã kiểm tra document tồn tại)
    return UserModel( // Trả về UserModel mới
      firstName: data['FirstName'], // Lấy firstName từ data
      id :  doc.id, // Lấy id từ document ID
      dateOfBirth: data['DateOfBirth'], // Lấy dateOfBirth từ data
      lastName: data['LastName'], // Lấy lastName từ data
      username: data['Username'], // Lấy username từ data
      email: data['Email'], // Lấy email từ data
      password: data['Password'], // Lấy password từ data
      phoneNo: data['PhoneNo'] ?? '', // Lấy phoneNo từ data, nếu null thì dùng chuỗi rỗng
      gender: data['Gender']??'' // Lấy gender từ data, nếu null thì dùng chuỗi rỗng
    );
  }
  UserModel copyWith(Map<String, dynamic> updates) { // Hàm tạo bản sao UserModel với một số thuộc tính được cập nhật
    return UserModel( // Trả về UserModel mới
      id: updates['id'] ?? this.id, // Nếu updates có 'id' thì dùng giá trị đó, ngược lại dùng id hiện tại
      firstName: updates['firstName'] ?? this.firstName, // Nếu updates có 'firstName' thì dùng giá trị đó, ngược lại dùng firstName hiện tại
      lastName: updates['lastName'] ?? this.lastName, // Nếu updates có 'lastName' thì dùng giá trị đó, ngược lại dùng lastName hiện tại
      username: updates['username'] ?? this.username, // Nếu updates có 'username' thì dùng giá trị đó, ngược lại dùng username hiện tại
      email: updates['email'] ?? this.email, // Nếu updates có 'email' thì dùng giá trị đó, ngược lại dùng email hiện tại
      password: updates['password'] ?? this.password, // Nếu updates có 'password' thì dùng giá trị đó, ngược lại dùng password hiện tại
      phoneNo: updates['phoneNo'] ?? this.phoneNo, // Nếu updates có 'phoneNo' thì dùng giá trị đó, ngược lại dùng phoneNo hiện tại
      gender: updates['gender'] ?? this.gender, // Nếu updates có 'gender' thì dùng giá trị đó, ngược lại dùng gender hiện tại
      dateOfBirth: updates['dateOfBirth'] ?? this.dateOfBirth, // Nếu updates có 'dateOfBirth' thì dùng giá trị đó, ngược lại dùng dateOfBirth hiện tại
    );
  }

}
