import 'package:flutter/material.dart';

class AddOrderPage extends StatefulWidget {
  @override
  _AddOrderPageState createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String? _customer;
  String? _soldBy;
  DateTime _orderDate = DateTime.now();
  List<Map<String, dynamic>> _orderItems = [];
  double _totalAmount = 0.0;
  String? _status;

  // Mock Data
  final List<String> _customers = ['Customer A', 'Customer B', 'Customer C'];
  final List<String> _users = ['User A', 'User B', 'User C'];
  final List<Map<String, dynamic>> _products = [
    {'id': 1, 'name': 'Product A', 'price': 50.0},
    {'id': 2, 'name': 'Product B', 'price': 30.0},
    {'id': 3, 'name': 'Product C', 'price': 70.0},
  ];
  final List<String> _statuses = ['PENDING', 'APPROVED', 'REJECTED', 'DELIVERED'];

  void _addOrderItem(Map<String, dynamic> product, int quantity) {
    setState(() {
      _orderItems.add({
        'product': product,
        'quantity': quantity,
        'totalPrice': product['price'] * quantity,
      });
      _totalAmount += product['price'] * quantity;
    });
  }

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      // Submit the order
      final order = {
        'customer': _customer,
        'soldBy': _soldBy,
        'orderDate': _orderDate.toIso8601String(),
        'orderItems': _orderItems,
        'totalAmount': _totalAmount,
        'status': _status,
      };
      print('Order Created: $order');

      // You can send this data to an API or save locally
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order Created Successfully')),
      );

      // Reset the form
      setState(() {
        _customer = null;
        _soldBy = null;
        _orderDate = DateTime.now();
        _orderItems = [];
        _totalAmount = 0.0;
        _status = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Order'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Customer'),
                value: _customer,
                items: _customers
                    .map((customer) =>
                    DropdownMenuItem(value: customer, child: Text(customer)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _customer = value;
                  });
                },
                validator: (value) =>
                value == null ? 'Please select a customer' : null,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Sold By'),
                value: _soldBy,
                items: _users
                    .map((user) =>
                    DropdownMenuItem(value: user, child: Text(user)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _soldBy = value;
                  });
                },
                validator: (value) => value == null ? 'Please select a user' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Order Date'),
                initialValue: _orderDate.toIso8601String(),
                readOnly: true,
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _orderDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null && picked != _orderDate) {
                    setState(() {
                      _orderDate = picked;
                    });
                  }
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Order Items',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _orderItems.length,
                itemBuilder: (context, index) {
                  final item = _orderItems[index];
                  return ListTile(
                    title: Text('${item['product']['name']}'),
                    subtitle: Text(
                        'Quantity: ${item['quantity']} | Total: \$${item['totalPrice']}'),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  _addOrderItem(_products[0], 2); // Mock adding a product
                },
                child: Text('Add Product'),
              ),
              SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Status'),
                value: _status,
                items: _statuses
                    .map((status) =>
                    DropdownMenuItem(value: status, child: Text(status)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _status = value;
                  });
                },
                validator: (value) => value == null ? 'Please select a status' : null,
              ),
              SizedBox(height: 16.0),
              Text(
                'Total Amount: \$$_totalAmount',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitOrder,
                child: Text('Submit Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
