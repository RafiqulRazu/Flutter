import 'package:flutter/material.dart';
import 'package:test_flutter/page/customer/AddCustomerPage.dart';
import 'package:test_flutter/page/lead/LeadPage.dart';
import 'package:test_flutter/page/product/AddProductPage.dart';
import 'package:test_flutter/page/activity/CreateActivity.dart';
import 'package:test_flutter/page/lead/CreateLead.dart';
import 'package:test_flutter/page/Login.dart';
import 'package:test_flutter/page/activity/ViewActivity.dart';
import 'package:test_flutter/page/customer/ViewCustomerPage.dart';
import 'package:test_flutter/page/product/ViewProductPage.dart';

class AgentPage extends StatelessWidget {
  const AgentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('AGENT DASHBOARD'),
          automaticallyImplyLeading: false, // Hides the back button
          backgroundColor: Colors.teal.shade600,
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Welcome, Agent!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      children: [
                        _buildDashboardCard(
                          context,
                          icon: Icons.shopping_cart,
                          label: 'Create Activity',
                          color: Colors.deepPurpleAccent,
                          onTap: () =>
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateActivityPage()),
                              ),
                        ),
                        _buildDashboardCard(
                          context,
                          icon: Icons.shopping_cart,
                          label: 'View Activity',
                          color: Colors.deepPurpleAccent,
                          onTap: () =>
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewActivityPage()),
                              ),
                        ),
                        // _buildDashboardCard(
                        //   context,
                        //   icon: Icons.shopping_cart,
                        //   label: 'Create Lead',
                        //   color: Colors.deepPurpleAccent,
                        //   onTap: () =>
                        //       Navigator.pushReplacement(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => CreateLeadPage()),
                        //       ),
                        // ),
                        _buildDashboardCard(
                          context,
                          icon: Icons.double_arrow,
                          label: 'All Lead',
                          color: Colors.deepPurpleAccent,
                          onTap: () =>
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewLeadPage()),
                              ),
                        ),
                        _buildDashboardCard(
                          context,
                          icon: Icons.people,
                          label: 'View Customer',
                          color: Colors.deepPurpleAccent,
                          onTap: () =>
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewCustomerPage()),
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ]
            )
        )
    );
  }


  Widget _buildDashboardCard(BuildContext context,
      {required IconData icon,
        required String label,
        required Color color,
        required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: color.withOpacity(0.6), width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: color,
                child: Icon(icon, size: 30, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


