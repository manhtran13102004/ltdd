import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore - database của Firebase
import 'package:flutter/material.dart'; // Import Flutter Material - cung cấp các widget cơ bản
import 'package:get/get.dart'; // Import GetX - dùng cho snackbar và state management
import 'package:project/features/authentication/models/user_model.dart'; // Import model UserModel

class userRepo extends GetxController { // Repository xử lý CRUD user - kế thừa GetxController
  static userRepo get instance => Get.find(); // Getter để lấy instance của userRepo từ GetX dependency injection
  final _db = FirebaseFirestore.instance; // Lấy instance của Firestore database
  createUser(UserModel user) async => await _db // Hàm tạo user mới - async function
          .collection('user') // Truy cập collection 'user' trong Firestore
          .add(user.toJson()) // Thêm document mới với dữ liệu từ user.toJson()
          .whenComplete(() => Get.snackbar('Success', "User has been created", // Khi hoàn thành thành công
              snackPosition: SnackPosition.BOTTOM, colorText: Colors.green)) // Hiển thị snackbar thành công ở dưới cùng với màu chữ xanh
          .catchError((error, stackTrace) { // Bắt lỗi nếu có
        Get.snackbar('Error', "User has not been created", // Hiển thị snackbar lỗi
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.red); // Ở dưới cùng với màu chữ đỏ
      });

  getUserDetail(String email) async { // Hàm lấy thông tin chi tiết user theo email
    final snapshot = // Lấy snapshot từ query
        await _db.collection('user').where('Email', isEqualTo: email).get(); // Query collection 'user' với điều kiện Email = email được truyền vào
if(snapshot.docs.isNotEmpty){ // Nếu có kết quả (không rỗng)
    final userData=snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single; // Chuyển đổi document đầu tiên thành UserModel
  return userData;} // Trả về userData
else { // Nếu không có kết quả
  return null; // Trả về null
}
  }
  getAllUser() async { // Hàm lấy tất cả user
    final snapshot = await _db.collection('user').get(); // Lấy tất cả documents từ collection 'user'

     final userData= snapshot.docs.map((e) => UserModel.fromSnapshot).toList(); // Chuyển đổi tất cả documents thành danh sách UserModel
    return userData; // Trả về danh sách userData
  }

  updateUser(UserModel user) async{ // Hàm cập nhật thông tin user
    try { // Bắt đầu khối try-catch để xử lý lỗi
      await _db.collection('user').doc(user.id).update(user.toJson()); // Cập nhật document có id = user.id với dữ liệu mới từ user.toJson()
    } catch (e) { // Bắt lỗi nếu có
      print('Failed to update user: $e'); // In thông báo lỗi ra console
    }
  }
  deleteUser(UserModel user) async { // Hàm xóa user
    try { // Bắt đầu khối try-catch để xử lý lỗi
      await _db.collection('user').doc(user.id).delete(); // Xóa document có id = user.id
      Get.snackbar('Success', 'Delete success'); // Hiển thị snackbar thông báo thành công
    }catch (e) { // Bắt lỗi nếu có
      print('Failed to update user: $e'); // In thông báo lỗi ra console (comment có thể sai, nên là 'Failed to delete user')
    }
  }
}


