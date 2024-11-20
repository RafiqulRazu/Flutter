class Customer {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? company;

  Customer(
      {this.id, this.name, this.email, this.phone, this.address, this.company});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['company'] = this.company;
    return data;
  }
}