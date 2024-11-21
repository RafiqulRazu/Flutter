import 'package:test_flutter/model/Customer.dart';
import 'package:test_flutter/model/User.dart';


class Activity {
  int id;
  String activityType;
  String description;
  String activityDate;
  Customer customer;
  User agent;

  Activity({
    required this.id,
    required this.activityType,
    required this.description,
    required this.activityDate,
    required this.customer,
    required this.agent,
  });

  // Factory constructor for JSON deserialization
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      activityType: json['activityType'],
      description: json['description'],
      activityDate: json['activityDate'],
      customer: Customer.fromJson(json['customer']),
      agent: User.fromJson(json['agent']),
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'activityType': activityType,
      'description': description,
      'activityDate': activityDate,
      'customer': customer.toJson(),
      'agent': agent.toJson(),
    };
  }

}

enum ActivityType {
  CALL,
  EMAIL,
  MEETING,
}
