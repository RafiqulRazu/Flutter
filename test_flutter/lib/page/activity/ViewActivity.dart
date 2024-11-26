import 'package:flutter/material.dart';
import 'package:test_flutter/model/Activity.dart';
import 'package:test_flutter/model/User.dart';
import 'package:test_flutter/page/AgentPage.dart';
import 'package:test_flutter/service/ActivityService.dart';
import 'package:test_flutter/service/AuthService.dart';
import 'package:test_flutter/service/LeadService.dart';

import '../../model/Lead.dart';

class ViewActivityPage extends StatefulWidget {
  @override
  _ViewActivityPageState createState() => _ViewActivityPageState();
}

class _ViewActivityPageState extends State<ViewActivityPage> {
  final ActivityService _activityService = ActivityService();
  final AuthService _authService = AuthService();
  final LeadService _leadService = LeadService();
  late Future<List<Activity>> _activities;

  @override
  void initState() {
    super.initState();
    _activities = _activityService.getAllActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities'),
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
      body: FutureBuilder<List<Activity>>(
        future: _activities,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No activities found.'));
          } else {
            final activities = snapshot.data!;
            return ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return ListTile(
                  leading: Icon(Icons.event_note),
                  title: Text(activity.activityType ?? ''),
                  subtitle: Text('Date: ${activity.activityDate}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteActivity(activity.id!),
                      ),
                      TextButton(
                        onPressed: () => _showAssignLeadDialog(activity),
                        child: Text(
                          'Lead',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  onTap: () => _viewActivityDetails(activity),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showAssignLeadDialog(Activity activity) async {
    List<User>? salesExecutives;

    // Fetch Sales Executives
    try {
      salesExecutives = await _authService.getAllSalesExecutives();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching sales executives: $e')),
      );
      return;
    }

    // Show Dialog with Local State Management
    showDialog(
      context: context,
      builder: (context) {
        User? selectedSalesExecutive;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Assign Lead'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<User>(
                    hint: Text('Select Sales Executive'),
                    value: selectedSalesExecutive,
                    items: salesExecutives
                        ?.map((user) =>
                        DropdownMenuItem(
                          value: user,
                          child: Text(user.name ?? ''),
                        ))
                        .toList(),
                    onChanged: (User? value) {
                      setState(() {
                        selectedSalesExecutive = value;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    if (selectedSalesExecutive != null) {
                      await _saveLead(activity, selectedSalesExecutive!);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(
                            'Please select a Sales Executive')),
                      );
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }


  // Save Lead
  Future<void> _saveLead(Activity activity, User salesExecutive) async {
    var lead = Lead(
        id: null,
        activity: activity,
        salesExecutive: salesExecutive,
        createdAt: null
    );

    try {
      await _leadService.createLead(lead);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lead assigned successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error assigning lead: $e')),
      );
    }
  }

  // Method to delete an activity
  void _deleteActivity(int activityId) async {
    try {
      await _activityService.deleteActivity(activityId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Activity deleted successfully!')),
      );
      setState(() {
        _activities = _activityService.getAllActivities();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting activity: $e')),
      );
    }
  }

  // Navigate to Activity Details Page
  void _viewActivityDetails(Activity activity) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Activity Details'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Type: ${activity.activityType}'),
                Text('Date: ${activity.activityDate}'),
                Text('Description: ${activity.description}'),
                if (activity.customer != null)
                  Text('Customer: ${activity.customer!.name}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          ),
    );
  }
}
