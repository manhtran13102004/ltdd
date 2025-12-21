// File chứa các hàm validation cho form inputs

class TValidator { // Class chứa các hàm validation tĩnh
  static String? validateEmail(String? value) { // Hàm tĩnh để validate email - trả về String? (null nếu hợp lệ, thông báo lỗi nếu không hợp lệ)
    if (value == null || value.isEmpty) { // Kiểm tra giá trị null hoặc rỗng
      return 'Email is required.'; // Trả về thông báo lỗi nếu email rỗng
    }

    final emailRegExp = RegExp( // Tạo regex pattern để kiểm tra định dạng email
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', // Pattern: ký tự@ký tự.tên miền (ít nhất 2 ký tự)
    );

    if (!emailRegExp.hasMatch(value)) { // Kiểm tra email có khớp với pattern không
      return 'Please enter a valid email address.'; // Trả về thông báo lỗi nếu không khớp
    }

    return null; // Trả về null nếu email hợp lệ (không có lỗi)
  }

  static String? validatePassword(String? value) { // Hàm tĩnh để validate password - trả về String? (null nếu hợp lệ, thông báo lỗi nếu không hợp lệ)
    if (value == null || value.isEmpty) { // Kiểm tra giá trị null hoặc rỗng
      return 'Password is required.'; // Trả về thông báo lỗi nếu password rỗng
    }

    if (value.length < 8) { // Kiểm tra độ dài password có ít nhất 8 ký tự không
      return 'Password must be at least 8 characters long.'; // Trả về thông báo lỗi nếu quá ngắn
    }

    if (!RegExp(r'\d').hasMatch(value)) { // Kiểm tra password có chứa ít nhất một chữ số không
      return 'Password must contain at least one number.'; // Trả về thông báo lỗi nếu không có số
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) { // Kiểm tra password có chứa ít nhất một chữ hoa không
      return 'Password must contain at least one uppercase letter.'; // Trả về thông báo lỗi nếu không có chữ hoa
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) { // Kiểm tra password có chứa ít nhất một ký tự đặc biệt không
      return 'Password must contain at least one special character.'; // Trả về thông báo lỗi nếu không có ký tự đặc biệt
    }

    return null; // Trả về null nếu password hợp lệ (không có lỗi)
  }

  static String? validatePhoneNumber(String? value) { // Hàm tĩnh để validate số điện thoại - trả về String? (null nếu hợp lệ, thông báo lỗi nếu không hợp lệ)
    if (value == null || value.isEmpty) { // Kiểm tra giá trị null hoặc rỗng
      return 'Phone number is required.'; // Trả về thông báo lỗi nếu số điện thoại rỗng
    }

    // Biểu thức chính quy để kiểm tra số điện thoại
    final phoneRegExp = RegExp(r'^\+?[0-9]{10,15}$'); // Pattern: có thể có dấu + ở đầu, sau đó là 10-15 chữ số

    if (!phoneRegExp.hasMatch(value)) { // Kiểm tra số điện thoại có khớp với pattern không
      return 'Please enter a valid phone number.'; // Trả về thông báo lỗi nếu không khớp
    }

    return null; // Trả về null nếu số điện thoại hợp lệ (không có lỗi)
  }
}
