import 'package:flutter/material.dart';
import 'package:test_flutter/page/SalesPage.dart';
import 'package:test_flutter/service/OrderService.dart';
import 'package:test_flutter/model/Order.dart';
import 'package:test_flutter/model/OrderItem.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  final OrderService orderService = OrderService();
  late Future<List<Order>> orders;

  @override
  void initState() {
    super.initState();
    orders = orderService.getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to AdminPage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SalesPage()),
            );
          },
        ),
      ),
      body: FutureBuilder<List<Order>>(
        future: orders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No orders found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final order = snapshot.data![index];
                return ListTile(
                  title: Text('Order #${order.id}'),
                  subtitle: Text('Total: \$${order.totalAmount}'),
                  trailing: Text(order.status.name), // Converts enum to string
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailsPage(order: order),
                      ),
                    );
                  },
                );
              },
            );

          }
        },
      ),
    );
  }
}

class OrderDetailsPage extends StatelessWidget {
  final Order order;

  OrderDetailsPage({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order #${order.id}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Status: ${order.status}', style: TextStyle(fontSize: 18)),
            Text('Total Amount: \$${order.totalAmount}',
                style: TextStyle(fontSize: 18)),
            Text('Order Date: ${order.orderDate}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Items:', style: TextStyle(fontSize: 20)),
            Expanded(
              child: ListView.builder(
                itemCount: order.orderItems.length,
                itemBuilder: (context, index) {
                  final item = order.orderItems[index];
                  return ListTile(
                    title: Text(item.product.name!),
                    subtitle: Text('Quantity: ${item.quantity}'),
                    trailing: Text('Unit Price: \$${item.product.unitPrice}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
