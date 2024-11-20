import 'package:flutter/material.dart';
import 'package:test_flutter/service/CustomerService.dart';

class AddCustomerPage extends StatefulWidget {
  const AddCustomerPage ({super.key});

  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}


class _AddCustomerPageState extends State<AddCustomerPage> {
  final _formKey = GlobalKey<FormState>();
  final CustomerService _customerService = CustomerService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _vatController = TextEditingController();
  String? _status = 'Available';

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
