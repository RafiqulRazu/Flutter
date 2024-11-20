import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_flutter/page/Login.dart';

class Registration extends StatefulWidget {
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController name = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController confirmPassword = TextEditingController();

  final TextEditingController phone = TextEditingController();

  final TextEditingController address = TextEditingController();

  String? selectedRole;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  // Method to validate form and check passwords
  void _register() async {
    if (_formKey.currentState!.validate()) {
      String uName = name.text;
      String uEmail = email.text;
      String uPassword = password.text;
      String uPhone = phone.text;
      String uAddress = address.text;
      String uRole = selectedRole ?? '';

      if (uRole.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a role')),
        );
        return;
      }

      setState(() {
        isLoading = true;
      });

      final response = await _sendDataToBackend(
        uName,
        uEmail,
        uPassword,
        uPhone,
        uAddress,
        uRole,
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Registration successful!');
        // Optionally navigate or show a success message
      } else if (response.statusCode == 409) {
        print('User already exists!');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User already exists!')),
        );
      } else {
        print('Registration failed with status: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed! Please try again.')),
        );
      }
    }
  }

  Future<http.Response> _sendDataToBackend(String name, String email,
      String password, String phone, String address, String role) async {
    // const String url = 'https://8ccf-103-205-69-8.ngrok-free.app/register'; // Android emulator
    const String url = 'http://localhost:8089/register';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'address': address,
        // 'role': role,
      }),
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Heading for Registration Form
                  Text(
                    'Registration Form',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Name TextField
                  _buildTextField(
                    controller: name,
                    label: 'Name',
                    icon: Icons.person,
                  ),
                  SizedBox(height: 15),

                  // Email TextField
                  _buildTextField(
                    controller: email,
                    label: 'Email',
                    icon: Icons.email,
                  ),
                  SizedBox(height: 15),

                  // Password TextField
                  _buildTextField(
                    controller: password,
                    label: 'Password',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  SizedBox(height: 15),

                  // Confirm Password TextField
                  _buildTextField(
                    controller: confirmPassword,
                    label: 'Confirm Password',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  SizedBox(height: 15),

                  // Phone TextField
                  _buildTextField(
                    controller: phone,
                    label: 'Cell Number',
                    icon: Icons.phone,
                  ),
                  SizedBox(height: 15),

                  // Address TextField
                  _buildTextField(
                    controller: address,
                    label: 'Address',
                    icon: Icons.home,
                  ),
                  SizedBox(height: 20),

                  // Role Selection
                  // Container(
                  //   width: 500,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         'ROLE:',
                  //         style: TextStyle(
                  //             fontSize: 16, fontWeight: FontWeight.w500),
                  //       ),
                  //       SizedBox(height: 10),
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //         children: [
                  //           _buildRadioOption('ADMIN', 'Admin'),
                  //           _buildRadioOption('SALES_EXECUTIVE', 'Sales'),
                  //           _buildRadioOption('AGENT', 'Agent'),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 20),

                  // Register Button with Loading Indicator
                  Center(
                    child: isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                      onPressed: _register,
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        minimumSize: Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Login Button (Text Button with Underline)
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text(
                        'Already have an account? Login',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
  }) {
    return Container(
      width: 600, // Set width to 500
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  // Helper function to create a radio button with a label
  // Widget _buildRadioOption(String value, String label) {
  //   return Expanded(
  //     child: Row(
  //       children: [
  //         Radio<String>(
  //           value: value,
  //           groupValue: selectedRole,
  //           onChanged: (String? newValue) {
  //             setState(() {
  //               selectedRole = newValue;
  //             });
  //           },
  //         ),
  //         Text(label),
  //       ],
  //     ),
  //   );
  // }
}
