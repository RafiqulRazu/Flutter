import 'package:flutter/material.dart';
import 'package:test_flutter/page/AgentPage.dart';
import '../../model/Customer.dart'; // Adjust the path as necessary
import '../../model/User.dart';
import '../../service/CustomerService.dart';
import 'package:test_flutter/page/AdminPage.dart';

class ViewCustomerPage extends StatefulWidget {
  @override
  _ViewCustomerPageState createState() => _ViewCustomerPageState();
}

class _ViewCustomerPageState extends State<ViewCustomerPage> {
  final CustomerService _customerService = CustomerService();
  List<Customer> _customers = [];
  User? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCustomers();
  }

  bool _isAdmin() {
    return _currentUser?.role == 'ADMIN';
  }

  Future<void> _fetchCustomers() async {
    try {
      List<Customer> customers = await _customerService.getAllCustomers();
      setState(() {
        _customers = customers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error fetching customers: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customers List"),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     // Navigate back to AdminPage
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(builder: (context) => AdminPage()),
        //     );
        //   },
        // ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (_isAdmin()) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AdminPage()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AgentPage()),
              );
            }
          },
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Phone')),
            DataColumn(label: Text('Address')),
          ],
          rows: _customers.map((customer) {
            return DataRow(cells: [
              DataCell(Text(customer.name ?? 'N/A')),
              DataCell(Text(customer.email ?? 'N/A')),
              DataCell(Text(customer.phone ?? 'N/A')),
              DataCell(Text(customer.address ?? 'N/A')),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}


