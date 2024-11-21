import 'package:flutter/material.dart';
import 'package:test_flutter/model/Activity.dart';
import 'package:test_flutter/service/ActivityService.dart';

class ViewActivityPage extends StatefulWidget {
  const ViewActivityPage({super.key});

  @override
  State<ViewActivityPage> createState() => _ViewActivityPageState();
}

class _ViewActivityPageState extends State<ViewActivityPage> {
  final ActivityService _customerService = ActivityService();
  List<Activity> _activities = [];
  bool _isLoading = true;

  @override
  void initState() {
  super.initState();
  //_fetchActivities();
  }

/*  Future<void> _fetchCustomers() async {
  try {
  List<Activity> customers = await _customerService.getAllActivities();
  setState(() {
  _activities = activities;
  _isLoading = false;
  });
  } catch (e) {
  setState(() {
  _isLoading = false;
  });
  print("Error fetching activities: $e");
  }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
