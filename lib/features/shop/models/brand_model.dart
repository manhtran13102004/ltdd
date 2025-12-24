import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  final String id;
  final String name;
  final String image;
  final bool isFeatured;
  final int productCount;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    required this.productCount,
  });

  factory BrandModel.fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return BrandModel(
      id: snap.id,
      name: data['Name'] ?? '',
      image: data['Image'] ?? '',
      isFeatured: data['IsFeatured'] ?? false,
      productCount: data['ProductCount'] ?? 0,
    );
  }

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['Id'] ?? '',
      name: json['Name'] ?? '',
      image: json['Image'] ?? '',
      isFeatured: json['IsFeatured'] ?? false,
      productCount: json['ProductCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'IsFeatured': isFeatured,
      'ProductCount': productCount,
    };
  }
}