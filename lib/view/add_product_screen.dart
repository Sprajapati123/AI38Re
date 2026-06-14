import 'package:ai38re/model/product_model.dart';
import 'package:ai38re/viewmodel/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageProductScreen extends StatefulWidget {
  const ManageProductScreen({super.key});

  @override
  State<ManageProductScreen> createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),
      body: Column(
        children: [
          TextFormField(controller: nameController),
          TextFormField(controller: priceController),
          TextFormField(controller: descController),

          ElevatedButton(
            onPressed: () async {
              final model = ProductModel(
                id: "",
                name: nameController.text,
                price: double.parse(priceController.text),
                description: descController.text,
              );
              final success = await vm.addProduct(model);
              if (success) {
                Navigator.pop(context);
              } else {}
            },
            child: vm.loading
                ? CircularProgressIndicator()
                : Text("Add Product"),
          ),
        ],
      ),
    );
  }
}
