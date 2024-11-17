import 'dart:convert';

import 'package:dio/dio.dart';
import '../model/Product.dart';
import 'package:http/http.dart' as http;
import 'package:test_flutter/service/AuthService.dart';

class ProductService {
  final Dio _dio = Dio();
  final String apiUrl = "http://localhost:8089/api/product/";

  Future<List<Product>> getAllProducts() async {
    try {
      final response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        List<dynamic> productJson = response.data;
        return productJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print("Error fetching products: $e");
      throw Exception("Error fetching products");
    }
  }


  Future<Product?> createProduct(Product customerData) async {
    final authService = AuthService();
    final token = await authService.getToken();
    final headers = {'Authorization': 'Bearer $token'};

    try {
      final response = await _dio.post(
        "${apiUrl}save",
        data: customerData.toJson(), // Corrected to use customerData
        options: Options(headers: headers), // Added headers for authorization
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Product.fromJson(response.data);
      } else {
        print("Error creating product: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error creating product: $e");
      return null;
    }
  }

  // Future<Product?> createProduct(Product customerData) async {
  //
  //   final authService = AuthService();
  //   final token = await authService.getToken();
  //   final headers = {'Authorization': 'Bearer $token'};
  //
  //
  //   try {
  //     final response = await _dio.post(
  //       "${apiUrl}save",
  //       data: productData.toJson(),
  //     );
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return Product.fromJson(response.data);
  //     } else {
  //       print("Error creating product: ${response.statusCode}");
  //       return null;
  //     }
  //   } catch (e) {
  //     print("Error creating product: $e");
  //     return null;
  //   }
  // }
}
