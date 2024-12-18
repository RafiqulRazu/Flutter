import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_flutter/model/Order.dart';

import 'AuthService.dart';

class OrderService {
  final String baseUrl = 'http://localhost:8089/api/order';
  final AuthService authService = AuthService();

  Future<List<Order>> getAllOrders() async {
    final response = await http.get(Uri.parse('$baseUrl/'));
    if (response.statusCode == 200) {
      final List<dynamic> ordersJson = json.decode(response.body);
      return ordersJson.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  // Create a new order
  Future<Order> createOrder(Order order) async {
    final response = await http.post(
      Uri.parse('$baseUrl/save'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(order.toJson()),
    );

    if (response.statusCode == 200) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create order');
    }
  }

  // Fetch an order by ID
  Future<Order> getOrderById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch order');
    }
  }


  // Delete an order by ID
  Future<void> deleteOrder(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete order');
    }
  }
}
