import 'package:flutter/material.dart';
import 'package:test_flutter/model/Activity.dart';
import 'package:test_flutter/model/Customer.dart';
import 'package:test_flutter/model/User.dart';
import 'package:test_flutter/page/AgentPage.dart';
import 'package:test_flutter/page/activity/ViewActivity.dart';
import 'package:test_flutter/service/ActivityService.dart';
import 'package:test_flutter/service/AuthService.dart';
import 'package:test_flutter/service/CustomerService.dart';

class CreateActivityPage extends StatefulWidget {
  @override
  _CreateActivityPageState createState() => _CreateActivityPageState();
}

class _CreateActivityPageState extends State<CreateActivityPage> {
  final _formKey = GlobalKey<FormState>();

  final ActivityService _activityService = ActivityService();
  final CustomerService _customerService = CustomerService();
  final AuthService _authService = AuthService();

  List<Customer> _customers = [];
  Customer? _selectedCustomer;

  ActivityType? _selectedActivityType;
  String? _description;
  DateTime? _activityDate;

  @override
  void initState() {
    super.initState();
    _loadCustomers();
  }

  void _loadCustomers() async {
    try {
      List<Customer> customers = await _customerService.getAllCustomers();
      setState(() {
        _customers = customers;
      });
    } catch (e) {
      _showErrorDialog('Error loading customers: $e');
    }
  }

  void _createActivity() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_selectedCustomer == null) {
        _showErrorDialog('Please select a customer.');
        return;
      }

      if (_selectedActivityType == null) {
        _showErrorDialog('Please select an activity type.');
        return;
      }

      if (_activityDate == null) {
        _showErrorDialog('Please select a date for the activity.');
        return;
      }

      Activity newActivity = Activity(
        id: 0,
        activityType: _selectedActivityType.toString().split('.').last,
        description: _description!,
        activityDate: _activityDate!.toIso8601String(),
        customer: _selectedCustomer!,
        agent: await _authService.getCurrentUser() ?? new User(),
      );

      try {
        await _activityService.createActivity(newActivity);
        _showSuccessDialog('Activity created successfully!');
      } catch (e) {
        _showErrorDialog('Error creating activity: $e');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ViewActivityPage()),
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Activity'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to AdminPage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AgentPage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Customer Dropdown
              DropdownButtonFormField<Customer>(
                decoration: InputDecoration(labelText: 'Customer'),
                value: _selectedCustomer,
                onChanged: (value) => setState(() => _selectedCustomer = value),
                items: _customers.map((customer) {
                  return DropdownMenuItem<Customer>(
                    value: customer,
                    child: Text(customer.name!),
                  );
                }).toList(),
                validator: (value) =>
                value == null ? 'Please select a customer' : null,
              ),
              // Activity Type Dropdown
              DropdownButtonFormField<ActivityType>(
                decoration: InputDecoration(labelText: 'Activity Type'),
                value: _selectedActivityType,
                onChanged: (value) =>
                    setState(() => _selectedActivityType = value),
                items: ActivityType.values.map((type) {
                  return DropdownMenuItem<ActivityType>(
                    value: type,
                    child: Text(type.toString().split('.').last.toUpperCase()),
                  );
                }).toList(),
                validator: (value) =>
                value == null ? 'Please select an activity type' : null,
              ),
              // Description Text Field
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value,
                validator: (value) =>
                value == null || value.isEmpty ? 'Description is required' : null,
              ),
              // Date Picker
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Activity Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() => _activityDate = pickedDate);
                  }
                },
                controller: TextEditingController(
                  text: _activityDate == null
                      ? ''
                      : '${_activityDate!.toLocal()}'.split(' ')[0],
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Please select a date' : null,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _createActivity,
                child: Text('Create Activity'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
