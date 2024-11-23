import 'package:flutter/material.dart';
import 'package:test_flutter/model/Product.dart';
import 'package:test_flutter/page/AdminPage.dart';
import 'package:test_flutter/service/ProductService.dart';



class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final ProductService _productService = ProductService();

  // TextEditingControllers to capture form input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _vatController = TextEditingController();
  String? _status = 'Available'; // Default status value


  bool _isSubmitting = false;



  Future<void> _createProduct() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      final product = Product(
        name: _nameController.text,
        unitPrice: int.tryParse(_priceController.text),
        stock: int.tryParse(_stockController.text),
        vat: int.tryParse(_vatController.text),
        status: _status,
      );

      final createdProduct = await _productService.createProduct(product);

      setState(() {
        _isSubmitting = false;
      });

      if (createdProduct != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Product created successfully")),
        );
        Navigator.pop(context); // Go back after adding product
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to create product")),
        );
      }
    }
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _nameController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _vatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Product"),
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Product Name"),
                validator: (value) =>
                value!.isEmpty ? "Please enter a product name" : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: "Unit Price"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? "Please enter the unit price" : null,
              ),
              TextFormField(
                controller: _stockController,
                decoration: InputDecoration(labelText: "Stock"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? "Please enter the stock" : null,
              ),
              TextFormField(
                controller: _vatController,
                decoration: InputDecoration(labelText: "VAT"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Please enter VAT" : null,
              ),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: InputDecoration(labelText: "Status"),
                items: ["Available", "Out of Stock"]
                    .map((status) => DropdownMenuItem(
                  value: status,
                  child: Text(status),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _status = value;
                  });
                },
              ),
              SizedBox(height: 20),
              _isSubmitting
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _createProduct,
                child: Text("Add Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



