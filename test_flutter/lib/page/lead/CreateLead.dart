// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class CreateLeadPage extends StatefulWidget {
//   @override
//   _CreateLeadPageState createState() => _CreateLeadPageState();
// }
//
// class _CreateLeadPageState extends State<CreateLeadPage> {
//   final _formKey = GlobalKey<FormState>();
//
//   // Controllers
//   final TextEditingController _customerIdController = TextEditingController();
//   final TextEditingController _soldByController = TextEditingController();
//   final TextEditingController _leadIdController = TextEditingController();
//
//   List<Map<String, dynamic>> _orderItems = [];
//   DateTime _orderDate = DateTime.now();
//
//   Future<void> createOrder() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     final url = Uri.parse('http://localhost:8080/api/order/save');
//     final Map<String, dynamic> payload = {
//       "customer": {"id": int.parse(_customerIdController.text)},
//       "soldBy": {"id": int.parse(_soldByController.text)},
//       "lead": {"id": int.parse(_leadIdController.text)},
//       "orderItems": _orderItems,
//       "orderDate": _orderDate.toIso8601String(),
//     };
//
//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(payload),
//       );
//
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Order created successfully!'),
//           backgroundColor: Colors.green,
//         ));
//         Navigator.pop(context);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('Failed to create order. Error: ${response.body}'),
//           backgroundColor: Colors.red,
//         ));
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('An error occurred: $e'),
//         backgroundColor: Colors.red,
//       ));
//     }
//   }
//
//   void _addOrderItem() {
//     setState(() {
//       _orderItems.add({"product": {"id": 0}, "quantity": 0});
//     });
//   }
//
//   void _updateOrderItem(int index, String key, dynamic value) {
//     setState(() {
//       _orderItems[index][key] = value;
//     });
//   }
//
//   void _removeOrderItem(int index) {
//     setState(() {
//       _orderItems.removeAt(index);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Create Order"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               // Customer ID
//               TextFormField(
//                 controller: _customerIdController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: "Customer ID"),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter a customer ID.";
//                   }
//                   return null;
//                 },
//               ),
//               // Sold By (User ID)
//               TextFormField(
//                 controller: _soldByController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: "Sold By (User ID)"),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter the ID of the sales user.";
//                   }
//                   return null;
//                 },
//               ),
//               // Lead ID
//               TextFormField(
//                 controller: _leadIdController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(labelText: "Lead ID"),
//               ),
//               SizedBox(height: 16),
//
//               // Order Items Section
//               Text(
//                 "Order Items",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: _orderItems.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 8),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           TextFormField(
//                             keyboardType: TextInputType.number,
//                             decoration: InputDecoration(labelText: "Product ID"),
//                             onChanged: (value) {
//                               _updateOrderItem(index, "product", {"id": int.parse(value)});
//                             },
//                           ),
//                           TextFormField(
//                             keyboardType: TextInputType.number,
//                             decoration: InputDecoration(labelText: "Quantity"),
//                             onChanged: (value) {
//                               _updateOrderItem(index, "quantity", int.parse(value));
//                             },
//                           ),
//                           SizedBox(height: 8),
//                           ElevatedButton(
//                             onPressed: () => _removeOrderItem(index),
//                             child: Text("Remove Item"),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.red,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               ElevatedButton(
//                 onPressed: _addOrderItem,
//                 child: Text("Add Order Item"),
//               ),
//               SizedBox(height: 16),
//
//               // Order Date
//               ListTile(
//                 title: Text("Order Date"),
//                 subtitle: Text(_orderDate.toLocal().toString().split(' ')[0]),
//                 trailing: IconButton(
//                   icon: Icon(Icons.calendar_today),
//                   onPressed: () async {
//                     final pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: _orderDate,
//                       firstDate: DateTime(2000),
//                       lastDate: DateTime(2101),
//                     );
//                     if (pickedDate != null) {
//                       setState(() {
//                         _orderDate = pickedDate;
//                       });
//                     }
//                   },
//                 ),
//               ),
//               SizedBox(height: 16),
//
//               // Submit Button
//               ElevatedButton(
//                 onPressed: createOrder,
//                 child: Text("Submit Order"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
