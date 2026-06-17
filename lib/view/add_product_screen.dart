import 'package:ai38re/model/product_model.dart';
import 'package:ai38re/viewmodel/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ManageProductScreen extends StatefulWidget {
  final id;

  const ManageProductScreen({super.key, this.id});

  @override
  State<ManageProductScreen> createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.id != null) {
        context.read<ProductViewModel>().getProductById(widget.id);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductViewModel>();
    if (widget.id != null && vm.product != null) {
      nameController.text = "${vm.product?.name}";
      priceController.text = "${vm.product?.price}";
      descController.text = "${vm.product?.description}";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? "Add Product" : "Update Product"),
      ),
      body: Column(
        children: [
          TextFormField(controller: nameController),
          TextFormField(controller: priceController),
          TextFormField(controller: descController),

          ElevatedButton(
            onPressed: () async {
              if (widget.id == null) {
                //add
                final model = ProductModel(
                  id: "",
                  name: nameController.text,
                  price: double.parse(priceController.text),
                  description: descController.text,
                );
                final success = await vm.addProduct(model);
                if (success) {
                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(msg: vm.error.toString());
                }
              } else {
                //update
              }
            },
            child: vm.loading
                ? CircularProgressIndicator()
                : Text(widget.id == null ? "Add Product" : "Update Product"),
          ),
        ],
      ),
    );
  }
}
