class Order {
  int? id;
  Null? lead;
  Customer? customer;
  SoldBy? soldBy;
  List<OrderItems>? orderItems;
  String? orderDate;
  int? totalAmount;
  String? status;

  Order(
      {this.id,
        this.lead,
        this.customer,
        this.soldBy,
        this.orderItems,
        this.orderDate,
        this.totalAmount,
        this.status});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lead = json['lead'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    soldBy =
    json['soldBy'] != null ? new SoldBy.fromJson(json['soldBy']) : null;
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(new OrderItems.fromJson(v));
      });
    }
    orderDate = json['orderDate'];
    totalAmount = json['totalAmount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lead'] = this.lead;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.soldBy != null) {
      data['soldBy'] = this.soldBy!.toJson();
    }
    if (this.orderItems != null) {
      data['orderItems'] = this.orderItems!.map((v) => v.toJson()).toList();
    }
    data['orderDate'] = this.orderDate;
    data['totalAmount'] = this.totalAmount;
    data['status'] = this.status;
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;

  Customer({this.id, this.name, this.email, this.phone, this.address});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}

class SoldBy {
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
  List<Authorities>? authorities;
  bool? lock;
  bool? accountNonLocked;
  bool? accountNonExpired;
  bool? credentialsNonExpired;

  SoldBy(
      {this.id,
        this.name,
        this.email,
        this.password,
        this.phone,
        this.address,
        this.role,
        this.active,
        this.enabled,
        this.username,
        this.authorities,
        this.lock,
        this.accountNonLocked,
        this.accountNonExpired,
        this.credentialsNonExpired});

  SoldBy.fromJson(Map<String, dynamic> json) {
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
    if (json['authorities'] != null) {
      authorities = <Authorities>[];
      json['authorities'].forEach((v) {
        authorities!.add(new Authorities.fromJson(v));
      });
    }
    lock = json['lock'];
    accountNonLocked = json['accountNonLocked'];
    accountNonExpired = json['accountNonExpired'];
    credentialsNonExpired = json['credentialsNonExpired'];
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
    if (this.authorities != null) {
      data['authorities'] = this.authorities!.map((v) => v.toJson()).toList();
    }
    data['lock'] = this.lock;
    data['accountNonLocked'] = this.accountNonLocked;
    data['accountNonExpired'] = this.accountNonExpired;
    data['credentialsNonExpired'] = this.credentialsNonExpired;
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

class OrderItems {
  int? id;
  Product? product;
  int? quantity;

  OrderItems({this.id, this.product, this.quantity});

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}

class Product {
  int? id;
  String? name;
  int? unitPrice;
  int? stock;
  int? vat;
  String? status;

  Product(
      {this.id, this.name, this.unitPrice, this.stock, this.vat, this.status});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    unitPrice = json['unitPrice'];
    stock = json['stock'];
    vat = json['vat'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['unitPrice'] = this.unitPrice;
    data['stock'] = this.stock;
    data['vat'] = this.vat;
    data['status'] = this.status;
    return data;
  }
}