class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? address;
  String? role;
  bool? active;
  bool? enabled;
  String? username;

  User(
      {this.id,
        this.name,
        this.email,
        this.password,
        this.phone,
        this.address,
        this.role,
        this.active,
        this.enabled,
        this.username
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    address = json['address'];
    role = json['role'];
    active = json['active'];
    enabled = json['enabled'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['role'] = this.role;
    data['active'] = this.active;
    data['enabled'] = this.enabled;
    data['username'] = this.username;
    return data;
  }
}

class Authorities {
  String? authority;

  Authorities({this.authority});

  Authorities.fromJson(Map<String, dynamic> json) {
    authority = json['authority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authority'] = this.authority;
    return data;
  }
}