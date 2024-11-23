import 'package:flutter/material.dart';
import 'package:test_flutter/service/ActivityService.dart';
import 'package:test_flutter/model/Activity.dart';

import '../AgentPage.dart';

class ViewActivityPage extends StatefulWidget {
  final int activityId;

  const ViewActivityPage({Key? key, required this.activityId}) : super(key: key);

  @override
  _ViewActivityPageState createState() => _ViewActivityPageState();
}

class _ViewActivityPageState extends State<ViewActivityPage> {
  late Future<Activity?> _activityFuture;

  @override
  void initState() {
    super.initState();
    // Fetch the activity by ID when the page initializes
    final activityService = ActivityService();
    _activityFuture = activityService.getActivityById(activityId: widget.activityId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('View Activity'),
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
      body: FutureBuilder<Activity?>(
        future: _activityFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading indicator while fetching data
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Display error message if an error occurs
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            // Render the activity details
            Activity activity = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activity ID: ${activity.id}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text('Description: ${activity.description}'),
                  SizedBox(height: 8),
                  Text('Date: ${activity.activityDate}'),
                  SizedBox(height: 8),
                  Text('Type: ${activity.activityType}'),
                ],
              ),
            );
          } else {
            // Handle case where no data is returned
            return Center(child: Text('No Activity Found'));
          }
        },
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:test_flutter/model/Activity.dart';
// import 'package:test_flutter/service/ActivityService.dart';
//
// class ViewActivityPage extends StatefulWidget {
//   // const ViewActivityPage({super.key});
//   final int activityId; // ID of the activity to be viewed
//
//   ViewActivityPage({required this.activityId});
//
//   @override
//   State<ViewActivityPage> createState() => _ViewActivityPageState();
// }
//
// class _ViewActivityPageState extends State<ViewActivityPage> {
//   final ActivityService _activityService = ActivityService();
//   Activity? _activity;
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadActivity();
//   }
//
//   void _loadActivity() async {
//     try {
//       Activity activity = await _activityService.getActivityById(widget.activityId);
//       setState(() {
//         _activity = activity;
//         _isLoading = false;
//       });
//     } catch (e) {
//       _showErrorDialog('Error loading activity: $e');
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Error'),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Activity Details'),
//       ),
//         body: _isLoading
//             ? Center(child: CircularProgressIndicator())
//             : _activity == null
//             ? Center(child: Text('Activity not found.'))
//             : Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ListView(
//             children: [
//               ListTile(
//                 title: Text('Activity ID'),
//                 subtitle: Text('${_activity!.id}'),
//               ),
//               ListTile(
//                 title: Text('Activity Type'),
//                 subtitle: Text('${_activity!.activityType}'),
//               ),
//               ListTile(
//                 title: Text('Description'),
//                 subtitle: Text(_activity!.description ?? 'No description'),
//               ),
//               ListTile(
//                 title: Text('Activity Date'),
//                 subtitle: Text('${_activity!.activityDate}'),
//               ),
//               ListTile(
//                 title: Text('Customer'),
//                 subtitle: Text('${_activity!.customer.name}'),
//               ),
//               ListTile(
//                 title: Text('Agent'),
//                 subtitle: Text('${_activity!.agent.name}'),
//               ),
//             ],
//           ),
//         ),
//
//     );
//   }
// }
