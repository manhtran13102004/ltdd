import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  const CartItemModel({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.image,
    this.variationId,
    this.selectedAttributes = const {},
  });

  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  final String image;
  final String? variationId;
  final Map<String, String> selectedAttributes;

  double get totalPrice => price * quantity;

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      id: id,
      productId: productId,
      title: title,
      price: price,
      quantity: quantity ?? this.quantity,
      image: image,
      variationId: variationId,
      selectedAttributes: selectedAttributes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'ProductId': productId,
      'Title': title,
      'Price': price,
      'Quantity': quantity,
      'Image': image,
      'VariationId': variationId ?? '',
      'SelectedAttributes': selectedAttributes,
    };
  }

  factory CartItemModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return CartItemModel(
      id: data['Id'] ?? doc.id,
      productId: data['ProductId'] ?? '',
      title: data['Title'] ?? '',
      price: (data['Price'] ?? 0.0).toDouble(),
      quantity: data['Quantity'] ?? 0,
      image: data['Image'] ?? '',
      variationId: data['VariationId'],
      selectedAttributes: Map<String, String>.from(data['SelectedAttributes'] ?? {}),
    );
  }

  static String buildItemId({
    required String productId,
    String variationId = '',
    Map<String, String>? selectedAttributes,
  }) {
    if (variationId.isNotEmpty) {
      return '$productId-$variationId';
    }
    if (selectedAttributes != null && selectedAttributes.isNotEmpty) {
      final entries = selectedAttributes.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key));
      final attrsKey = entries.map((e) => '${e.key}:${e.value}').join('|');
      return '$productId-$attrsKey';
    }
    return productId;
  }

  String get attributesLabel {
    if (selectedAttributes.isEmpty) return '';
    final entries = selectedAttributes.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    return entries.map((e) => '${e.key}: ${e.value}').join(', ');
  }
}
