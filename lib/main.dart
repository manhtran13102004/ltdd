import 'package:flutter/cupertino.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:project/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/firebase_options.dart';
import 'package:project/repository/auth_repo/AuthenticationRepository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



Future<void> main() async {
  // Hàm main là điểm bắt đầu của app Flutter
  // Future<void> + async vì trong main có các tác vụ bất đồng bộ (await)

  await Supabase.initialize(
    // Khởi tạo Supabase client trước khi app chạy
    // Supabase dùng làm Backend (Auth, Database, Storage)
    url: 'https://ckbvijuaedwjhymeqfhx.supabase.co',
    // URL project Supabase của bạn
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNrYnZpanVhZWR3amh5bWVxZmh4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEyMzA3NDAsImV4cCI6MjA0NjgwNjc0MH0.D6GoadsDebtk7C-wFF_DrRPTNUAk7yM-6IjXvuunipc',
    // Anonymous public key dùng để truy cập Supabase
    // Key này an toàn khi để phía client
  );


  WidgetsFlutterBinding.ensureInitialized();
  // Đảm bảo Flutter engine đã sẵn sàng
  // BẮT BUỘC phải gọi trước khi dùng Firebase, plugin native, splash screen

  FlutterNativeSplash.preserve;
  // Giữ splash screen hiển thị
  // Tránh màn hình trắng khi app đang khởi tạo (Firebase, Supabase...)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform
    // Khởi tạo Firebase theo nền tảng (Android / iOS / Web)
    // DefaultFirebaseOptions được sinh ra từ flutterfire configure
  ).then(
          (value)=> Get.put(AuthenticationRepository())
    // Sau khi Firebase khởi tạo xong:
    // Đưa AuthenticationRepository vào GetX dependency injection
    // => Có thể gọi ở bất kỳ đâu trong app bằng Get.find()
  );

  runApp(const App());
  // Chạy ứng dụng Flutter
  // App là widget gốc của toàn bộ ứng dụng
}


