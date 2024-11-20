import 'package:flutter/material.dart';
// import 'package:test_flutter/model/Activity.dart';
// import 'package:test_flutter/model/Customer.dart';
// import 'package:test_flutter/model/User.dart';
// import 'package:test_flutter/service/ActivityService.dart';
// import 'package:test_flutter/service/CustomerService.dart';
// import 'package:test_flutter/service/UserService.dart';
//
class CreateActivityPage extends StatefulWidget {
  @override
  _CreateActivityPageState createState() => _CreateActivityPageState();
}

class _CreateActivityPageState extends State<CreateActivityPage> {
  final _formKey = GlobalKey<FormState>();
//
//   final ActivityService _activityService = ActivityService();
//   final CustomerService _customerService = CustomerService();
//   // final UserService _userService = UserService();
//
//   List<Customer> _customers = [];
//   List<User> _agents = [];
//   Customer? _selectedCustomer;
//   User? _selectedAgent;
//
//   String? _activityType;
//   String? _description;
//   DateTime? _activityDate;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadCustomers();
//     _loadAgents();
//   }
//
//   void _loadCustomers() async {
//     try {
//       List<Customer> customers = await _customerService.getAllCustomers();
//       setState(() {
//         _customers = customers;
//       });
//     } catch (e) {
//       _showErrorDialog('Error loading customers: $e');
//     }
//   }
//
//   void _loadAgents() async {
//     try {
//       List<User> agents = await _userService.getAllUsers();
//       setState(() {
//         _agents = agents;
//       });
//     } catch (e) {
//       _showErrorDialog('Error loading agents: $e');
//     }
//   }
//
//   void _createActivity() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//
//       if (_selectedCustomer == null || _selectedAgent == null) {
//         _showErrorDialog('Please select both a customer and an agent.');
//         return;
//       }
//
//       ActivityModel newActivity = ActivityModel(
//         id: 0, // Backend will assign the ID
//         activityType: _activityType!,
//         description: _description!,
//         activityDate: _activityDate!.toIso8601String(),
//         customer: _selectedCustomer!,
//         agent: _selectedAgent!,
//       );
//
//       try {
//         await _activityService.createActivity(newActivity);
//         _showSuccessDialog('Activity created successfully!');
//       } catch (e) {
//         _showErrorDialog('Error creating activity: $e');
//       }
//     }
//   }
//
//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Error'),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showSuccessDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Success'),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context); // Close dialog
//               Navigator.pop(context); // Navigate back
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Activity'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               DropdownButtonFormField<Customer>(
//                 decoration: InputDecoration(labelText: 'Customer'),
//                 value: _selectedCustomer,
//                 onChanged: (value) => setState(() => _selectedCustomer = value),
//                 items: _customers.map((customer) {
//                   return DropdownMenuItem<Customer>(
//                     value: customer,
//                     child: Text(Customer.name),
//                   );
//                 }).toList(),
//                 validator: (value) =>
//                 value == null ? 'Please select a customer' : null,
//               ),
//               DropdownButtonFormField<User>(
//                 decoration: InputDecoration(labelText: 'Agent'),
//                 value: _selectedAgent,
//                 onChanged: (value) => setState(() => _selectedAgent = value),
//                 items: _agents.map((agent) {
//                   return DropdownMenuItem<User>(
//                     value: agent,
//                     child: Text(agent.name),
//                   );
//                 }).toList(),
//                 validator: (value) =>
//                 value == null ? 'Please select an agent' : null,
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Activity Type'),
//                 onSaved: (value) => _activityType = value,
//                 validator: (value) =>
//                 value == null || value.isEmpty ? 'Activity type is required' : null,
//               ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Description'),
//                 onSaved: (value) => _description = value,
//                 validator: (value) =>
//                 value == null || value.isEmpty ? 'Description is required' : null,
//               ),
//               TextButton(
//                 onPressed: () async {
//                   DateTime? pickedDate = await showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(2000),
//                     lastDate: DateTime(2100),
//                   );
//                   if (pickedDate != null) {
//                     setState(() => _activityDate = pickedDate);
//                   }
//                 },
//                 child: Text(
//                   _activityDate == null
//                       ? 'Select Activity Date'
//                       : 'Activity Date: ${_activityDate!.toLocal()}'.split(' ')[0],
//                 ),
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _createActivity,
//                 child: Text('Create Activity'),
//               ),
//             ],
//           ),
//         ),
//       ),
    );
  }
}
