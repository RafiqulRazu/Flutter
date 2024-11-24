import 'package:test_flutter/model/Activity.dart';
import 'package:test_flutter/model/User.dart';

class Lead {
  final int? id; // Lead ID
  final Activity? activity; // Associated Activity
  final User? salesExecutive; // Sales Executive associated with the lead
  final DateTime? createdAt; // Lead creation date

  Lead({
    this.id,
    this.activity,
    this.salesExecutive,
    this.createdAt,
  });

  // Factory constructor to create a Lead object from JSON
  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
      id: json['id'],
      activity: json['activity'] != null ? Activity.fromJson(json['activity']) : null,
      salesExecutive: json['salesExecutive'] != null
          ? User.fromJson(json['salesExecutive'])
          : null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Method to convert Lead object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'activity': activity?.toJson(),
      'salesExecutive': salesExecutive?.toJson(),
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}


