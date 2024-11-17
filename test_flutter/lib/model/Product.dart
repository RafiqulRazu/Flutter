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