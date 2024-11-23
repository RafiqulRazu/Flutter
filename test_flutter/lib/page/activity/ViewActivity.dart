import 'package:flutter/material.dart';
import 'package:test_flutter/model/Activity.dart';
import 'package:test_flutter/service/ActivityService.dart';

class ViewActivityPage extends StatefulWidget {
  @override
  _ViewActivityPageState createState() => _ViewActivityPageState();
}

class _ViewActivityPageState extends State<ViewActivityPage> {
  final ActivityService _activityService = ActivityService();
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
                  title: Text(activity.activityType),
                  subtitle: Text('Date: ${activity.activityDate}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteActivity(activity.id),
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
      builder: (context) => AlertDialog(
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





// import 'package:flutter/material.dart';
// import 'package:test_flutter/service/ActivityService.dart';
// import 'package:test_flutter/model/Activity.dart';
//
// import '../AgentPage.dart';
//
// class ViewActivityPage extends StatefulWidget {
//   final int activityId;
//
//   const ViewActivityPage({Key? key, required this.activityId}) : super(key: key);
//
//   @override
//   _ViewActivityPageState createState() => _ViewActivityPageState();
// }
//
// class _ViewActivityPageState extends State<ViewActivityPage> {
//   late Future<Activity?> _activityFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     // Fetch the activity by ID when the page initializes
//     final activityService = ActivityService();
//     _activityFuture = activityService.getActivityById(activityId: widget.activityId);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Text('View Activity'),
//           leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             // Navigate back to AdminPage
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => AgentPage()),
//             );
//           },
//         ),
//       ),
//       body: FutureBuilder<Activity?>(
//         future: _activityFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // Show loading indicator while fetching data
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             // Display error message if an error occurs
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData && snapshot.data != null) {
//             // Render the activity details
//             Activity activity = snapshot.data!;
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Activity ID: ${activity.id}',
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//                   ),
//                   SizedBox(height: 8),
//                   Text('Description: ${activity.description}'),
//                   SizedBox(height: 8),
//                   Text('Date: ${activity.activityDate}'),
//                   SizedBox(height: 8),
//                   Text('Type: ${activity.activityType}'),
//                 ],
//               ),
//             );
//           } else {
//             // Handle case where no data is returned
//             return Center(child: Text('No Activity Found'));
//           }
//         },
//       ),
//     );
//   }
// }

