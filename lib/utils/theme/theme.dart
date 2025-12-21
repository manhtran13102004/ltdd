import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp ThemeData
import 'package:project/utils/theme/custom_themes/text_theme.dart'; // Import text theme

import 'custom_themes/appbar_theme.dart'; // Import AppBar theme
import 'custom_themes/bottom_sheet_theme.dart'; // Import BottomSheet theme
import 'custom_themes/checkbox_theme.dart'; // Import Checkbox theme
import 'custom_themes/chip_theme.dart'; // Import Chip theme
import 'custom_themes/elevated_button_theme.dart'; // Import ElevatedButton theme
import 'custom_themes/outlined_button_theme.dart'; // Import OutlinedButton theme
import 'custom_themes/text_field_theme.dart'; // Import TextField theme

class TAppTheme { // Class chứa theme của app (light và dark)
  TAppTheme._(); // Constructor private - ngăn việc tạo instance từ bên ngoài (singleton pattern)

  static ThemeData lightTheme = ThemeData( // Theme sáng (light theme)
    useMaterial3: true, // Sử dụng Material Design 3
    fontFamily: 'Poppins', // Font chữ mặc định là Poppins (có thể không khớp với font trong pubspec.yaml là Urbanist)
    brightness: Brightness.light, // Độ sáng = sáng
    primaryColor: Colors.blue, // Màu primary = xanh dương
    scaffoldBackgroundColor: Colors.white, // Màu nền Scaffold = trắng
    textTheme:  TTextTheme.lightTextTheme, // Text theme sáng
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme, // ElevatedButton theme sáng
    chipTheme: TChipTheme.lightChipTheme, // Chip theme sáng
    appBarTheme: TAppBarTheme.lightAppBarTheme, // AppBar theme sáng
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme, // Checkbox theme sáng
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme, // BottomSheet theme sáng
    outlinedButtonTheme: TOutlinedButtonTheme.lightTOutlinedButtonTheme, // OutlinedButton theme sáng
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme, // InputDecoration theme sáng

  );
  static ThemeData darkTheme = ThemeData( // Theme tối (dark theme)
    useMaterial3: true, // Sử dụng Material Design 3
    fontFamily: 'Poppins', // Font chữ mặc định là Poppins (có thể không khớp với font trong pubspec.yaml là Urbanist)
    brightness: Brightness.dark, // Độ sáng = tối
    primaryColor: Colors.blue, // Màu primary = xanh dương
    scaffoldBackgroundColor: Colors.black, // Màu nền Scaffold = đen
    textTheme:  TTextTheme.darkTextTheme, // Text theme tối
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme, // ElevatedButton theme tối
    chipTheme: TChipTheme.darkChipTheme, // Chip theme tối
    appBarTheme: TAppBarTheme.darkAppBarTheme, // AppBar theme tối
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme, // Checkbox theme tối
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme, // BottomSheet theme tối
    outlinedButtonTheme: TOutlinedButtonTheme.darkTOutlinedButtonTheme, // OutlinedButton theme tối
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme, // InputDecoration theme tối

  );
}
