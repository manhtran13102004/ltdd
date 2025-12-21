import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho context và navigation
import 'package:get/get_core/src/get_main.dart'; // Import GetX core (có thể không cần thiết)
import 'package:intl/intl.dart'; // Import thư viện intl - dùng để format ngày tháng

class THelperFunctions { // Class chứa các hàm helper tĩnh
  static Color? getColor(String value) { // Hàm tĩnh để lấy màu từ tên màu (string)
    if (value == 'Green') { // Nếu giá trị là 'Green'
      return Colors.green; // Trả về màu xanh lá
    } else if (value == 'Blue') { // Nếu giá trị là 'Blue'
      return Colors.blue; // Trả về màu xanh dương
    } else if (value == 'Pink') { // Nếu giá trị là 'Pink'
      return Colors.pink; // Trả về màu hồng
    } else if (value == 'Gray') { // Nếu giá trị là 'Gray'
      return Colors.grey; // Trả về màu xám
    } else if (value == 'White') { // Nếu giá trị là 'White'
      return Colors.white; // Trả về màu trắng
    } else if (value == 'Black') { // Nếu giá trị là 'Black'
      return Colors.black; // Trả về màu đen
    } else if (value == 'Purple') { // Nếu giá trị là 'Purple'
      return Colors.purple; // Trả về màu tím
    } else if (value == 'Indigo') { // Nếu giá trị là 'Indigo'
      return Colors.indigo; // Trả về màu chàm
    } else if (value == 'Teal') { // Nếu giá trị là 'Teal'
      return Colors.teal; // Trả về màu Teal
    }
    return null; // Trả về null nếu không khớp với bất kỳ màu nào
  }

  static void showSnackBar(String messenger) { // Hàm tĩnh để hiển thị SnackBar
    if (Get.context != null) { // Kiểm tra context có tồn tại không
      ScaffoldMessenger.of(Get.context!).showSnackBar( // Lấy ScaffoldMessenger từ context và hiển thị SnackBar
        SnackBar(content: Text(messenger)), // Tạo SnackBar với nội dung là messenger
      );
    } else { // Nếu context null
      print('Context is null. Cannot show SnackBar.'); // In thông báo lỗi ra console
    }
  }

  static void showAlert(String title, String message) { // Hàm tĩnh để hiển thị AlertDialog
    if (Get.context != null) { // Kiểm tra context có tồn tại không
      showDialog( // Hiển thị dialog
        context: Get.context!, // Context từ GetX
        builder: (BuildContext context) { // Builder function để tạo dialog
          return AlertDialog( // Trả về AlertDialog
            title: Text(title), // Tiêu đề của dialog
            content: Text(message), // Nội dung của dialog
            actions: [ // Danh sách các nút action
              TextButton( // Nút "OK"
                onPressed: () => Navigator.of(context).pop(), // Khi click, đóng dialog
                child: const Text('OK'), // Text hiển thị "OK"
              ),
            ],
          );
        },
      );
    } else { // Nếu context null
      print('Context is null. Cannot show alert.'); // In thông báo lỗi ra console
    }
  }
  static void navigateToScreen(BuildContext context, Widget screen) { // Hàm tĩnh để điều hướng đến màn hình khác
    Navigator.push( // Điều hướng đến màn hình mới (push vào stack)
      context, // Context hiện tại
      MaterialPageRoute(builder: (_) => screen), // Tạo MaterialPageRoute với screen được truyền vào
    );
  }

  static String truncateText(String text, int maxLength){ // Hàm tĩnh để cắt ngắn text nếu quá dài
    if(text.length <= maxLength){ // Nếu độ dài text nhỏ hơn hoặc bằng maxLength
      return text; // Trả về text gốc
    }else{ // Nếu độ dài text lớn hơn maxLength
      return '${text.substring(0,maxLength)}....'; // Cắt text từ đầu đến maxLength và thêm "...."
    }
  }


  static bool isDarkMode (BuildContext context){ // Hàm tĩnh để kiểm tra chế độ dark mode
    return Theme.of(context).brightness == Brightness.dark; // So sánh brightness của theme với Brightness.dark
  }

  static Size screenSize(){ // Hàm tĩnh để lấy kích thước màn hình
    return MediaQuery.of(Get.context!).size; // Lấy size từ MediaQuery của context từ GetX
  }

  static double screenHeight(){ // Hàm tĩnh để lấy chiều cao màn hình
    return MediaQuery.of(Get.context!).size.height; // Lấy height từ MediaQuery
  }
  static double screenWidth(){ // Hàm tĩnh để lấy chiều rộng màn hình
    return MediaQuery.of(Get.context!).size.width; // Lấy width từ MediaQuery
  }

  static String getFormattedDate (DateTime date, {String format = 'dd MMM yyyy'}){ // Hàm tĩnh để format ngày tháng
    return DateFormat(format).format(date); // Format date theo format được chỉ định (mặc định là 'dd MMM yyyy')
  }

  static List<T> removeDuplicates<T>(List<T> list) { // Hàm generic tĩnh để loại bỏ phần tử trùng lặp
    return list.toSet().toList(); // Chuyển list thành Set (tự động loại bỏ trùng lặp) rồi chuyển lại thành List
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) { // Hàm tĩnh để chia widgets thành các hàng
    final wrappedList = <Widget>[]; // Khởi tạo danh sách rỗng để chứa các Row

    for (var i = 0; i < widgets.length; i += rowSize) { // Lặp qua widgets với bước nhảy = rowSize
      final rowChildren = widgets.sublist( // Lấy một phần của danh sách widgets
        i, // Bắt đầu từ vị trí i
        (i + rowSize > widgets.length) ? widgets.length : i + rowSize, // Kết thúc ở vị trí i + rowSize hoặc cuối danh sách nếu không đủ
      );

      wrappedList.add(Row(children: rowChildren)); // Thêm Row chứa các widgets vào danh sách
    }

    return wrappedList; // Trả về danh sách các hàng
  }

}

