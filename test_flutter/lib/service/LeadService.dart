import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:test_flutter/service/AuthService.dart';
import '../model/Lead.dart'; // Import the Lead model class (ensure you have a Lead model)

class LeadService {
  final Dio _dio = Dio();
  final String apiUrl = "http://localhost:8089/api/lead/"; // Replace with your actual API URL

  // Get all leads
  Future<List<Lead>> getAllLeads() async {
    try {
      final response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        List<dynamic> leadJson = response.data;
        return leadJson.map((json) => Lead.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load leads");
      }
    } catch (e) {
      print("Error fetching leads: $e");
      throw Exception("Error fetching leads");
    }
  }

  // Create a new lead
  Future<Lead?> createLead(Lead lead) async {
    final authService = AuthService();
    final token = await authService.getToken();
    final headers = {
      'Authorization': 'Bearer $token', // Add token if required
    };

    try {
      final response = await _dio.post(
        "${apiUrl}save", // Adjust the endpoint based on your backend
        data: jsonEncode(lead.toJson()), // Assuming the Lead model has a `toJson` method
        options: Options(headers: headers), // Added headers for authorization
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Lead.fromJson(response.data); // Assuming the backend returns the created lead
      } else {
        print("Error creating lead: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error creating lead: $e");
      return null;
    }
  }

  // Get lead by ID
  Future<Lead?> getLeadById(int id) async {
    try {
      final response = await _dio.get("$apiUrl$id");

      if (response.statusCode == 200) {
        return Lead.fromJson(response.data);
      } else {
        throw Exception("Failed to load lead");
      }
    } catch (e) {
      print("Error fetching lead by ID: $e");
      throw Exception("Error fetching lead by ID");
    }
  }

  // Update an existing lead
  Future<Lead?> updateLead(int id, Lead leadData) async {
    final authService = AuthService();
    final token = await authService.getToken();
    final headers = {'Authorization': 'Bearer $token'};

    try {
      final response = await _dio.put(
        "${apiUrl}update/$id",
        data: leadData.toJson(), // Assuming the Lead model has a `toJson` method
        options: Options(headers: headers), // Added headers for authorization
      );

      if (response.statusCode == 200) {
        return Lead.fromJson(response.data); // Return updated lead
      } else {
        print("Error updating lead: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error updating lead: $e");
      return null;
    }
  }

  // Delete a lead
  Future<void> deleteLead(int id) async {
    final authService = AuthService();
    final token = await authService.getToken();
    final headers = {'Authorization': 'Bearer $token'};

    try {
      final response = await _dio.delete(
        "$apiUrl$id",
        options: Options(headers: headers), // Added headers for authorization
      );

      if (response.statusCode == 200) {
        print("Lead deleted successfully");
      } else {
        throw Exception("Failed to delete lead");
      }
    } catch (e) {
      print("Error deleting lead: $e");
      throw Exception("Error deleting lead");
    }
  }
}
