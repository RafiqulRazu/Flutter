import 'package:test_flutter/model/lead.dart';
import 'package:test_flutter/model/customer.dart';
import 'package:test_flutter/model/user.dart';
import 'package:test_flutter/model/OrderItem.dart';

class Order {
  final int id;
  final Lead? lead;
  final Customer customer;
  final User soldBy;
  final List<OrderItem> orderItems;
  final DateTime orderDate;
  final double totalAmount;
  final OrderStatus status;

  Order({
    required this.id,
    this.lead,
    required this.customer,
    required this.soldBy,
    required this.orderItems,
    required this.orderDate,
    required this.totalAmount,
    required this.status,
  });

  // Factory constructor to parse JSON into an Order object
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      lead: json['lead'] != null ? Lead.fromJson(json['lead']) : null,
      customer: Customer.fromJson(json['customer']),
      soldBy: User.fromJson(json['soldBy']),
      orderItems: (json['orderItems'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      orderDate: DateTime.parse(json['orderDate']),
      totalAmount: json['totalAmount'],
      status: OrderStatus.values.byName(json['status']),
    );
  }

  // Method to convert Order object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lead': lead?.toJson(),
      'customer': customer.toJson(),
      'soldBy': soldBy.toJson(),
      'orderItems': orderItems.map((item) => item.toJson()).toList(),
      'orderDate': orderDate.toIso8601String(),
      'totalAmount': totalAmount,
      'status': status.name,
    };
  }
}

// Enum for OrderStatus
enum OrderStatus {
  PENDING,
  APPROVED,
  REJECTED,
  DELIVERED
}
