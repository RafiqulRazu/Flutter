import 'package:test_flutter/model/Customer.dart';
import 'package:test_flutter/model/User.dart';


class ActivityModel {
  int id;
  String activityType;
  String description;
  String activityDate;
  Customer customer;
  User agent;

  ActivityModel({
    required this.id,
    required this.activityType,
    required this.description,
    required this.activityDate,
    required this.customer,
    required this.agent,
  });

  // Factory constructor for JSON deserialization
  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
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










// class Activity {
//   int? id;
//   String? activityType;
//   String? description;
//   String? activityDate;
//   Customer? customer;
//   Agent? agent;
//
//   Activity(
//       {this.id,
//         this.activityType,
//         this.description,
//         this.activityDate,
//         this.customer,
//         this.agent});
//
//   Activity.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     activityType = json['activityType'];
//     description = json['description'];
//     activityDate = json['activityDate'];
//     customer = json['customer'] != null
//         ? new Customer.fromJson(json['customer'])
//         : null;
//     agent = json['agent'] != null ? new Agent.fromJson(json['agent']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['activityType'] = this.activityType;
//     data['description'] = this.description;
//     data['activityDate'] = this.activityDate;
//     if (this.customer != null) {
//       data['customer'] = this.customer!.toJson();
//     }
//     if (this.agent != null) {
//       data['agent'] = this.agent!.toJson();
//     }
//     return data;
//   }
// }
//
// class Customer {
//   int? id;
//   String? name;
//   String? email;
//   String? phone;
//   String? address;
//
//   Customer({this.id, this.name, this.email, this.phone, this.address});
//
//   Customer.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     address = json['address'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['address'] = this.address;
//     return data;
//   }
// }
//
// class Agent {
//   int? id;
//   String? name;
//   String? email;
//   String? password;
//   String? phone;
//   String? address;
//   String? role;
//   bool? active;
//   bool? enabled;
//   String? username;
//   List<Authorities>? authorities;
//   bool? lock;
//   bool? accountNonLocked;
//   bool? accountNonExpired;
//   bool? credentialsNonExpired;
//
//   Agent(
//       {this.id,
//         this.name,
//         this.email,
//         this.password,
//         this.phone,
//         this.address,
//         this.role,
//         this.active,
//         this.enabled,
//         this.username,
//         this.authorities,
//         this.lock,
//         this.accountNonLocked,
//         this.accountNonExpired,
//         this.credentialsNonExpired});
//
//   Agent.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     password = json['password'];
//     phone = json['phone'];
//     address = json['address'];
//     role = json['role'];
//     active = json['active'];
//     enabled = json['enabled'];
//     username = json['username'];
//     if (json['authorities'] != null) {
//       authorities = <Authorities>[];
//       json['authorities'].forEach((v) {
//         authorities!.add(new Authorities.fromJson(v));
//       });
//     }
//     lock = json['lock'];
//     accountNonLocked = json['accountNonLocked'];
//     accountNonExpired = json['accountNonExpired'];
//     credentialsNonExpired = json['credentialsNonExpired'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['phone'] = this.phone;
//     data['address'] = this.address;
//     data['role'] = this.role;
//     data['active'] = this.active;
//     data['enabled'] = this.enabled;
//     data['username'] = this.username;
//     if (this.authorities != null) {
//       data['authorities'] = this.authorities!.map((v) => v.toJson()).toList();
//     }
//     data['lock'] = this.lock;
//     data['accountNonLocked'] = this.accountNonLocked;
//     data['accountNonExpired'] = this.accountNonExpired;
//     data['credentialsNonExpired'] = this.credentialsNonExpired;
//     return data;
//   }
// }
//
// class Authorities {
//   String? authority;
//
//   Authorities({this.authority});
//
//   Authorities.fromJson(Map<String, dynamic> json) {
//     authority = json['authority'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['authority'] = this.authority;
//     return data;
//   }
// }