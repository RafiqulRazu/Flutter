import 'package:flutter/material.dart';
import 'package:test_flutter/model/Lead.dart';
import 'package:test_flutter/page/AgentPage.dart';
import 'package:test_flutter/page/SalesPage.dart';
import 'package:test_flutter/service/LeadService.dart';

import '../../model/User.dart';

class ViewLeadPage extends StatefulWidget {
  @override
  _ViewLeadPageState createState() => _ViewLeadPageState();
}

class _ViewLeadPageState extends State<ViewLeadPage> {
  final LeadService _leadService = LeadService();
  late Future<List<Lead>> _leadsFuture;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _leadsFuture = _leadService.getAllLeads(); // Fetch leads on initialization
  }

  bool _isAgent() {
    return _currentUser?.role == 'AGENT';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Leads"),
        // leading: IconButton(
        //         //   icon: Icon(Icons.arrow_back),
        //         //   onPressed: () {
        //         //     // Navigate back to AdminPage
        //         //     Navigator.pushReplacement(
        //         //       context,
        //         //       MaterialPageRoute(builder: (context) => AgentPage()),
        //         //     );
        //         //   },
        //         // ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (_isAgent()) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AgentPage()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SalesPage()),
              );
            }
          },
        ),
      ),
      body: FutureBuilder<List<Lead>>(
        future: _leadsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error fetching leads: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No leads found"));
          }

          final leads = snapshot.data!;
          return ListView.builder(
            itemCount: leads.length,
            itemBuilder: (context, index) {
              final lead = leads[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(lead.id.toString()),
                  ),
                  title: Text("Activity ID: ${lead.activity?.id ?? 'N/A'}"),
                  subtitle: Text(
                      "Sales Executive: ${lead.salesExecutive?.name ?? 'N/A'}\nCreated At: ${lead.createdAt}"),
                  onTap: () {
                    // Navigate to lead details or perform another action
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeadDetailsPage(lead: lead),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Example Lead Details Page for further information
class LeadDetailsPage extends StatelessWidget {
  final Lead lead;

  LeadDetailsPage({required this.lead});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lead Details (ID: ${lead.id})"),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Activity ID: ${lead.activity?.id ?? 'N/A'}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Sales Executive: ${lead.salesExecutive?.name ?? 'N/A'}",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              "Created At: ${lead.createdAt}",
              style: TextStyle(fontSize: 16),
            ),
            // Add other lead details as needed
          ],
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
//
// class ViewLeadPage extends StatefulWidget {
//   const ViewLeadPage({super.key});
//
//   @override
//   State<ViewLeadPage> createState() => _ViewLeadPageState();
// }
//
// class _ViewLeadPageState extends State<ViewLeadPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//     );
//   }
// }
