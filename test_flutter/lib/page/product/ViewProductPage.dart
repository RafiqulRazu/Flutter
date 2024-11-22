import 'package:flutter/material.dart';
import 'package:test_flutter/model/Product.dart'; // Import your Product model
import 'package:test_flutter/page/product/AddProductPage.dart';
import 'package:test_flutter/service/ProductService.dart'; // Import your ProductService
import 'package:test_flutter/page/AdminPage.dart';

class ViewProductPage extends StatefulWidget {
  const ViewProductPage({super.key});

  @override
  _ViewProductPageState createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      List<Product> products = await _productService.getAllProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error fetching products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to AdminPage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AdminPage()),
            );
          },
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return Card(
                  elevation: 4, // Adds shadow to create a floating effect
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0), // Adds inner padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name ?? 'Unknown Product',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("Price: \$${product.unitPrice}",
                            style: TextStyle(color: Colors.black54)),
                        Text("Stock: ${product.stock}",
                            style: TextStyle(color: Colors.black54)),
                        Text("VAT: ${product.vat}%",
                            style: TextStyle(color: Colors.black54)),
                        Text("Status: ${product.status}",
                            style: TextStyle(
                                color: product.status == "Available"
                                    ? Colors.green
                                    : Colors.red)),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the AddProductPage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductPage()),
          );
        },
        child: Icon(Icons.add), // Icon for "Add"
        tooltip: "Add Product",
      ),
    );
  }
}
