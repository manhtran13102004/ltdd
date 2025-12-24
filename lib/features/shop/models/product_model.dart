import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/features/shop/models/product_atrribute.dart';
import 'package:project/features/shop/models/product_variation.dart';
import 'brand_model.dart';

class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand; // Nested brand object (nếu có)
  String? description;
  String? categoryId;
  String? brandId; // ← THÊM BRANDID RIÊNG ĐỂ FILTER ĐÚNG NHƯ FIREBASE CỦA MÀY
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.sku,
    this.salePrice = 0.0,
    this.isFeatured,
    this.brand,
    this.description,
    this.categoryId,
    this.brandId, // ← BẮT BUỘC TRUYỀN KHI CÓ
    this.images,
    this.productAttributes,
    this.productVariations,
  });

  static ProductModel empty() => ProductModel(
    id: '',
    stock: 0,
    price: 0.0,
    title: '',
    thumbnail: '',
    productType: '',
  );

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Stock': stock,
      'SKU': sku,
      'Price': price,
      'Title': title,
      'SalePrice': salePrice,
      'Thumbnail': thumbnail,
      'IsFeatured': isFeatured,
      'Brand': brand?.toJson(),
      'Description': description,
      'CategoryId': categoryId,
      'BrandId': brandId, // ← LƯU BRANDID RIÊNG
      'Images': images,
      'ProductType': productType,
      'ProductAttribute': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'ProductVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      stock: data['Stock'] ?? 0,
      sku: data['SKU'],
      price: (data['Price'] as num).toDouble(),
      title: data['Title'] ?? '',
      salePrice: (data['SalePrice'] as num?)?.toDouble() ?? 0.0,
      thumbnail: data['Thumbnail'] ?? '',
      isFeatured: data['IsFeatured'],
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
      description: data['Description'],
      categoryId: data['CategoryId']?.toString(),
      brandId: data['BrandId']?.toString(), // ← LẤY BRANDID RIÊNG TỪ FIREBASE
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      productType: data['ProductType'] ?? '',
      productAttributes: data['ProductAttribute'] != null
          ? (data['ProductAttribute'] as List)
          .map((e) => ProductAttributeModel.fromJson(e))
          .toList()
          : [],
      productVariations: data['ProductVariations'] != null
          ? (data['ProductVariations'] as List)
          .map((e) => ProductVariationModel.fromJson(e))
          .toList()
          : [],
    );
  }
}