import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp TextTheme

class TTextTheme { // Class chứa Text theme (light và dark)
  TTextTheme._(); // Constructor private - ngăn việc tạo instance từ bên ngoài (singleton pattern)

  static  TextTheme lightTextTheme = TextTheme( // Text theme sáng
    headlineLarge: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black), // Style cho headlineLarge: font size 32, đậm, màu đen
    headlineMedium: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.black), // Style cho headlineMedium: font size 24, font weight 600, màu đen
    headlineSmall: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black), // Style cho headlineSmall: font size 18, font weight 600, màu đen

    titleLarge: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black), // Style cho titleLarge: font size 16, font weight 600, màu đen
    titleMedium: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black), // Style cho titleMedium: font size 16, font weight 500, màu đen
    titleSmall: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black), // Style cho titleSmall: font size 16, font weight 400, màu đen

    bodyLarge: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black), // Style cho bodyLarge: font size 14, font weight 500, màu đen
    bodyMedium: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black), // Style cho bodyMedium: font size 14, font weight bình thường, màu đen
    bodySmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.5)), // Style cho bodySmall: font size 14, font weight 500, màu đen với độ mờ 50%

    labelLarge: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black), // Style cho labelLarge: font size 12, font weight bình thường, màu đen
    labelMedium: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black), // Style cho labelMedium: font size 12, font weight bình thường, màu đen
    labelSmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.black.withOpacity(0.5)), // Style cho labelSmall: font size 12, font weight bình thường, màu đen với độ mờ 50%
  );

  static  TextTheme darkTextTheme = const TextTheme( // Text theme tối
    headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white), // Style cho headlineLarge: font size 32, đậm, màu trắng
    headlineMedium: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.white), // Style cho headlineMedium: font size 24, font weight 600, màu trắng
    headlineSmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white), // Style cho headlineSmall: font size 18, font weight 600, màu trắng

    titleLarge: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white), // Style cho titleLarge: font size 16, font weight 600, màu trắng
    titleMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white), // Style cho titleMedium: font size 16, font weight 500, màu trắng
    titleSmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white), // Style cho titleSmall: font size 16, font weight 400, màu trắng

    bodyLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.white), // Style cho bodyLarge: font size 14, font weight 500, màu trắng
    bodyMedium: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white), // Style cho bodyMedium: font size 14, font weight bình thường, màu trắng
    bodySmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.white), // Style cho bodySmall: font size 14, font weight 500, màu trắng (có thể nên có độ mờ)

    labelLarge: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white), // Style cho labelLarge: font size 12, font weight bình thường, màu trắng
    labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white), // Style cho labelMedium: font size 12, font weight bình thường, màu trắng
    labelSmall: TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white), // Style cho labelSmall: font size 12, font weight bình thường, màu trắng (có thể nên có độ mờ)
  );
}
