import 'dart:convert';
import 'package:dio/dio.dart';
import '../model/Customer.dart';
import 'package:test_flutter/service/AuthService.dart';

class CustomerService {
  final Dio _dio = Dio();
  final String apiUrl = "http://localhost:8089/api/customer/";

  // Get all customers
  Future<List<Customer>> getAllCustomers() async {
    try {
      final response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        List<dynamic> customerJson = response.data;
        return customerJson.map((json) => Customer.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load customers");
      }
    } catch (e) {
      print("Error fetching customers: $e");
      throw Exception("Error fetching customers");
    }
  }

  // Create a new customer
  Future<Customer?> createCustomer(Customer customerData) async {

    final authService = AuthService();
    final token = await authService.getToken();
    final headers = {'Authorization': 'Bearer $token'};


    try {
      final response = await _dio.post(
        "${apiUrl}save",
        data: customerData.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Customer.fromJson(response.data);
      } else {
        print("Error creating customer: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error creating customer: $e");
      return null;
    }
  }

  // Delete a customer by ID
  Future<void> deleteCustomer(int id) async {
    try {
      await _dio.delete("${apiUrl}delete/$id");
    } catch (e) {
      print("Error deleting customer: $e");
      throw Exception("Error deleting customer");
    }
  }

  // Update a customer by ID
  Future<Customer?> updateCustomer(int id, Customer customer) async {
    try {
      final response = await _dio.put(
        "${apiUrl}update/$id",
        data: customer.toJson(),
      );
      if (response.statusCode == 200) {
        return Customer.fromJson(response.data);
      } else {
        print("Error updating customer: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error updating customer: $e");
      return null;
    }
  }

  // Get a customer by ID
  Future<Customer?> getById(int id) async {
    try {
      final response = await _dio.get("$apiUrl$id");
      if (response.statusCode == 200) {
        return Customer.fromJson(response.data);
      } else {
        print("Error fetching customer by ID: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error fetching customer by ID: $e");
      return null;
    }
  }

  getCustomersForAgent() {}
}



