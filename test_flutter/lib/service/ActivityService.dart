import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_flutter/model/Activity.dart';

class ActivityService {
  final String apiUrl = 'http://localhost:8089/api/act'; // Base API URL

  // Common headers for requests
  final Map<String, String> headers = {'Content-Type': 'application/json'};

  // Fetch all activities
  Future<List<ActivityModel>> getAllActivities() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/'), headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => ActivityModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load activities: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching activities: $e');
    }
  }

  // Create a new activity
  Future<ActivityModel> createActivity(ActivityModel activity) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/save'),
        headers: headers,
        body: json.encode(activity.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return ActivityModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create activity: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating activity: $e');
    }
  }

  // Delete an activity
  Future<void> deleteActivity(int activityId) async {
    try {
      final response =
      await http.delete(Uri.parse('$apiUrl/delete/$activityId'), headers: headers);

      if (response.statusCode != 200) {
        throw Exception('Failed to delete activity: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting activity: $e');
    }
  }

  // Update an activity
  Future<ActivityModel> updateActivity(int activityId, ActivityModel updatedActivity) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/update/$activityId'),
        headers: headers,
        body: json.encode(updatedActivity.toJson()),
      );

      if (response.statusCode == 200) {
        return ActivityModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to update activity: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating activity: $e');
    }
  }

  // Fetch activity by ID
  Future<ActivityModel> getActivityById(int activityId) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/$activityId'), headers: headers);

      if (response.statusCode == 200) {
        return ActivityModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to fetch activity: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching activity by ID: $e');
    }
  }
}
