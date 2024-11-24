import 'package:test_flutter/model/product.dart';

class OrderItem {
  final int id;
  final Product product;
  final int quantity;

  OrderItem({
    required this.id,
    required this.product,
    required this.quantity,
  });

  // Factory constructor to create an OrderItem object from JSON
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }

  // Method to convert OrderItem object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
    };
  }
}
