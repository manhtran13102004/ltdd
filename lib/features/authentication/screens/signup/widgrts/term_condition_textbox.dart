import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho state management
import 'package:project/features/authentication/controllers.onboarding/signup_controller.dart'; // Import controller xử lý logic đăng ký

import '../../../../../utils/constants/colors.dart'; // Import màu sắc chuẩn
import '../../../../../utils/constants/sizes.dart'; // Import kích thước chuẩn
import '../../../../../utils/constants/text_strings.dart'; // Import các chuỗi text chuẩn
import '../../../../../utils/helpers/helper_functions.dart'; // Import các hàm helper

class TTermAndConditionTextBox extends StatelessWidget { // Widget checkbox đồng ý điều khoản - StatelessWidget
  const TTermAndConditionTextBox({ // Constructor
    super.key, // Key từ parent widget

  });
  @override
  Widget build(BuildContext context) { // Hàm build - xây dựng UI
    final controller  =Get.put(SignupController()); // Khởi tạo và đăng ký SignupController vào GetX dependency injection
    final dark = THelperFunctions.isDarkMode(context); // Kiểm tra chế độ dark mode
    return Row( // Row - sắp xếp checkbox và text theo chiều ngang
      children: [ // Danh sách các widget con
        SizedBox( // SizedBox để giới hạn kích thước checkbox
          width: 24, // Chiều rộng 24 pixels
          height: 24, // Chiều cao 24 pixels
          child: Obx(()=>Checkbox( // Checkbox - Obx để tự động rebuild khi agree thay đổi
              value: controller.agree.value, // Giá trị checkbox: true nếu đã đồng ý, false nếu chưa
              onChanged: (value){ // Callback khi click checkbox
                controller.agree.value= !controller.agree.value; // Đảo ngược giá trị agree
              }),
          ),),
        const SizedBox(width: TSizes.spaceBtwItems), // Khoảng cách giữa checkbox và text

        Text.rich( // Text.rich - cho phép định dạng nhiều phần text khác nhau
          TextSpan( // TextSpan - định nghĩa một đoạn text với style riêng
            children: [ // Danh sách các TextSpan con
              TextSpan(text:   '${TTexts.iAgreeTo } ',  style:  Theme.of(context).textTheme.bodySmall), // Text "Tôi đồng ý với" với style bodySmall
              TextSpan(text:   '${TTexts.privacyPolicy } ',  style:  Theme.of(context).textTheme.bodyMedium!.apply( // Text "Chính sách bảo mật" với style bodyMedium và gạch chân
                decoration: TextDecoration.underline, // Gạch chân text
                color: dark ? TColors.white : TColors.primary, // Màu text: nếu dark mode thì dùng màu trắng, ngược lại dùng màu primary
                decorationColor: dark ? TColors.white : TColors.primary, // Màu gạch chân: nếu dark mode thì dùng màu trắng, ngược lại dùng màu primary

              )),
              TextSpan(text:  '${ TTexts.and  } ',  style:  Theme.of(context).textTheme.bodySmall), // Text "và" với style bodySmall
              TextSpan(text:   '${TTexts.termsOfUse } ',  style:  Theme.of(context).textTheme.bodyMedium!.apply( // Text "Điều khoản sử dụng" với style bodyMedium và gạch chân
                decoration: TextDecoration.underline, // Gạch chân text
                color: dark ? TColors.white : TColors.primary, // Màu text: nếu dark mode thì dùng màu trắng, ngược lại dùng màu primary
                decorationColor: dark ? TColors.white : TColors.primary, // Màu gạch chân: nếu dark mode thì dùng màu trắng, ngược lại dùng màu primary

              )),
            ],
          ),
        ),

      ],
    );
  }
}