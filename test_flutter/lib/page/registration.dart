import 'package:flutter/material.dart';
import 'package:dob_input_field/dob_input_field.dart';
import 'package:date_field/date_field.dart';
import 'package:google_fonts/google_fonts.dart';

class Registration extends StatefulWidget {
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController userName = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController confirmPassword = TextEditingController();

  final TextEditingController cell = TextEditingController();

  final TextEditingController address = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  // Method to validate form and check passwords
  void _register() {
    if (_formKey.currentState!.validate()) {
      String uName = userName.text;
      String uEmail = email.text;
      String uPassword = password.text;

      // Registration logic goes here (e.g., sending data to server)

      print('Name: $uName, Email: $uEmail, Password: $uPassword');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: userName,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: email,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.password),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: confirmPassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.password),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: cell,
                        decoration: InputDecoration(
                            labelText: 'Cell Number',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: address,
                        decoration: InputDecoration(
                            labelText: 'Adress',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.home)),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      ElevatedButton(
                          onPressed: () {
                            _register();
                          },
                          child: Text(
                            "Registration",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.lato().fontFamily),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                          )),
                    ],
                  ),
                ))));
  }
}
