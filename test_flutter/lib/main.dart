import 'package:flutter/material.dart';
import 'package:test_flutter/page/activity/ViewActivity.dart';
import 'package:test_flutter/page/customer/AddCustomerPage.dart';
import 'package:test_flutter/page/order/AddOrderPage.dart';
import 'package:test_flutter/page/product/AddProductPage.dart';
import 'package:test_flutter/page/AdminPage.dart';
import 'package:test_flutter/page/AgentPage.dart';
import 'package:test_flutter/page/SalesPage.dart';
import 'package:test_flutter/page/customer/ViewCustomerPage.dart';
import 'package:test_flutter/page/product/ViewProductPage.dart';
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
      // home: AdminPage(),
      // home: SalesPage(),
      home: Login(),
      // home: Login(),
      // home: AddCustomerPage(),
      // home: ViewActivityPage(),
    );
  }
}
