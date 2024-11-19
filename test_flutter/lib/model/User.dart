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
  List<Authorities>? authorities;
  String? username;
  bool? lock;
  bool? credentialsNonExpired;
  bool? accountNonExpired;
  bool? accountNonLocked;

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
        this.authorities,
        this.username,
        this.lock,
        this.credentialsNonExpired,
        this.accountNonExpired,
        this.accountNonLocked});

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
    if (json['authorities'] != null) {
      authorities = <Authorities>[];
      json['authorities'].forEach((v) {
        authorities!.add(new Authorities.fromJson(v));
      });
    }
    username = json['username'];
    lock = json['lock'];
    credentialsNonExpired = json['credentialsNonExpired'];
    accountNonExpired = json['accountNonExpired'];
    accountNonLocked = json['accountNonLocked'];
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
    if (this.authorities != null) {
      data['authorities'] = this.authorities!.map((v) => v.toJson()).toList();
    }
    data['username'] = this.username;
    data['lock'] = this.lock;
    data['credentialsNonExpired'] = this.credentialsNonExpired;
    data['accountNonExpired'] = this.accountNonExpired;
    data['accountNonLocked'] = this.accountNonLocked;
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