import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/product_service.dart';
import '../models/product.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _description = '';
  double _price = 0;
  String _category = '';

  List<String> _categories = ['Electronics', 'Clothing', 'Books', 'Other'];

  void _addProduct() async {
    if (_formKey.currentState!.validate()) {
      final productService = Provider.of<ProductService>(context, listen: false);
      final newProduct = Product(
        id: DateTime.now().toString(),
        name: _name,
        description: _description,
        price: _price,
        category: _category,
      );
      await productService.addProduct(newProduct);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) => value!.isEmpty ? 'Please enter a product name' : null,
                onChanged: (value) => _name = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
                onChanged: (value) => _description = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price (IDR)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter a price' : null,
                onChanged: (value) => _price = double.tryParse(value) ?? 0,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Category'),
                value: _category.isNotEmpty ? _category : null,
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _category = newValue ?? '';
                  });
                },
                validator: (value) => value == null ? 'Please select a category' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Add Product'),
                onPressed: _addProduct,
              ),
            ],
          ),
        ),
      ),
    );
  }
}