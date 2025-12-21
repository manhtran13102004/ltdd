import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp CheckboxThemeData

class TCheckboxTheme { // Class chứa Checkbox theme (light và dark)
  TCheckboxTheme._(); // Constructor private - ngăn việc tạo instance từ bên ngoài (singleton pattern)

  static CheckboxThemeData lightCheckboxTheme = CheckboxThemeData( // Checkbox theme sáng
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), // Hình dạng: bo góc với bán kính 4 pixels
    checkColor: MaterialStateProperty.resolveWith(( states) { // Màu dấu check: resolve dựa trên state
      if (states.contains(MaterialState.selected)) { // Nếu checkbox được chọn
        return Colors.white; // Màu dấu check = trắng
      }
      return Colors.black; // Nếu không được chọn thì màu đen (có thể không hiển thị)
    }),
    fillColor: MaterialStateProperty.resolveWith(( states) { // Màu nền checkbox: resolve dựa trên state
      if (states.contains(MaterialState.selected)) { // Nếu checkbox được chọn
        return Colors.blue.withOpacity(0.5); // Màu nền = xanh dương với độ mờ 50%
      }
      return Colors.transparent; // Nếu không được chọn thì trong suốt
    }),
  );

  static CheckboxThemeData darkCheckboxTheme = CheckboxThemeData( // Checkbox theme tối
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), // Hình dạng: bo góc với bán kính 4 pixels
    checkColor: MaterialStateProperty.resolveWith(( states) { // Màu dấu check: resolve dựa trên state
      if (states.contains(MaterialState.selected)) { // Nếu checkbox được chọn
        return Colors.white; // Màu dấu check = trắng
      }
      return Colors.black; // Nếu không được chọn thì màu đen (có thể không hiển thị)
    }),
    fillColor: MaterialStateProperty.resolveWith(( states) { // Màu nền checkbox: resolve dựa trên state
      if (states.contains(MaterialState.selected)) { // Nếu checkbox được chọn
        return Colors.blue.withOpacity(0.5); // Màu nền = xanh dương với độ mờ 50%
      }
      return Colors.transparent; // Nếu không được chọn thì trong suốt
    }),
  );
}
