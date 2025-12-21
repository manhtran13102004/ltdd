import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp InputDecorationTheme

class TTextFormFieldTheme { // Class chứa TextFormField theme (light và dark)
  TTextFormFieldTheme._(); // Constructor private - ngăn việc tạo instance từ bên ngoài (singleton pattern)

  static InputDecorationTheme lightInputDecorationTheme= InputDecorationTheme( // InputDecoration theme sáng
    errorMaxLines: 3, // Số dòng tối đa cho thông báo lỗi (3 dòng)
    prefixIconColor: Colors.grey, // Màu icon ở đầu TextField: xám
    suffixIconColor: Colors.grey, // Màu icon ở cuối TextField: xám
    labelStyle: const TextStyle().copyWith(fontSize: 14,color:Colors.black), // Style cho label: font size 14, màu đen
    hintStyle: const TextStyle().copyWith(fontSize: 14,color:Colors.black), // Style cho hint text: font size 14, màu đen
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal), // Style cho thông báo lỗi: font style bình thường
    floatingLabelStyle: const TextStyle().copyWith(color: Colors.black.withOpacity(0.8)), // Style cho floating label: màu đen với độ mờ 80%
    border: const OutlineInputBorder().copyWith( // Border mặc định
      borderRadius: BorderRadius.circular(14), // Bo góc với bán kính 14 pixels
      borderSide: const BorderSide(width: 1, color: Colors.grey), // Viền: độ dày 1 pixel, màu xám
    ),
      enabledBorder: const OutlineInputBorder().copyWith( // Border khi TextField được enable
    borderRadius: BorderRadius.circular(14), // Bo góc với bán kính 14 pixels
    borderSide: const BorderSide(width: 1, color: Colors.grey), // Viền: độ dày 1 pixel, màu xám
    ),
    focusedBorder: const OutlineInputBorder().copyWith( // Border khi TextField được focus
    borderRadius: BorderRadius.circular(14), // Bo góc với bán kính 14 pixels
    borderSide: const BorderSide(width: 1, color: Colors.black12), // Viền: độ dày 1 pixel, màu đen nhạt
    ),
    errorBorder: const OutlineInputBorder().copyWith( // Border khi TextField có lỗi
      borderRadius: BorderRadius.circular(14), // Bo góc với bán kính 14 pixels
      borderSide: const BorderSide(width: 1, color: Colors.red), // Viền: độ dày 1 pixel, màu đỏ
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith( // Border khi TextField có lỗi và đang được focus
      borderRadius: BorderRadius.circular(14), // Bo góc với bán kính 14 pixels
      borderSide: const BorderSide(width: 2, color: Colors.orange), // Viền: độ dày 2 pixels, màu cam
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme= InputDecorationTheme( // InputDecoration theme tối
    errorMaxLines: 3, // Số dòng tối đa cho thông báo lỗi (3 dòng)
    prefixIconColor: Colors.grey, // Màu icon ở đầu TextField: xám
    suffixIconColor: Colors.grey, // Màu icon ở cuối TextField: xám
    labelStyle: const TextStyle().copyWith(fontSize: 14,color:Colors.white), // Style cho label: font size 14, màu trắng
    hintStyle: const TextStyle().copyWith(fontSize: 14,color:Colors.white), // Style cho hint text: font size 14, màu trắng
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal), // Style cho thông báo lỗi: font style bình thường
    floatingLabelStyle: const TextStyle().copyWith(color: Colors.black.withOpacity(0.8)), // Style cho floating label: màu đen với độ mờ 80% (có thể nên là màu trắng cho dark theme)
    border: const OutlineInputBorder().copyWith( // Border mặc định
      borderRadius: BorderRadius.circular(14), // Bo góc với bán kính 14 pixels
      borderSide: const BorderSide(width: 1, color: Colors.grey), // Viền: độ dày 1 pixel, màu xám
    ),
    enabledBorder: const OutlineInputBorder().copyWith( // Border khi TextField được enable
      borderRadius: BorderRadius.circular(14), // Bo góc với bán kính 14 pixels
      borderSide: const BorderSide(width: 1, color: Colors.grey), // Viền: độ dày 1 pixel, màu xám
    ),
    focusedBorder: const OutlineInputBorder().copyWith( // Border khi TextField được focus
      borderRadius: BorderRadius.circular(14), // Bo góc với bán kính 14 pixels
      borderSide: const BorderSide(width: 1, color: Colors.white), // Viền: độ dày 1 pixel, màu trắng
    ),
    errorBorder: const OutlineInputBorder().copyWith( // Border khi TextField có lỗi
      borderRadius: BorderRadius.circular(14), // Bo góc với bán kính 14 pixels
      borderSide: const BorderSide(width: 1, color: Colors.red), // Viền: độ dày 1 pixel, màu đỏ
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith( // Border khi TextField có lỗi và đang được focus
      borderRadius: BorderRadius.circular(14), // Bo góc với bán kính 14 pixels
      borderSide: const BorderSide(width: 2, color: Colors.orange), // Viền: độ dày 2 pixels, màu cam
    ),
  );

}
