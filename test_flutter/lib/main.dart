import 'package:flutter/material.dart';
import 'package:test_flutter/page/AddProductPage.dart';
import 'package:test_flutter/page/AdminPage.dart';
import 'package:test_flutter/page/ViewCustomerPage.dart';
import 'package:test_flutter/page/ViewProductPage.dart';
import 'package:test_flutter/page/login.dart';
import 'package:test_flutter/page/registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ViewCustomerPage(),
    );
  }
}
