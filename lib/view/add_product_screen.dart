import 'dart:io';

import 'package:ai38re/model/product_model.dart';
import 'package:ai38re/viewmodel/image_view_model.dart';
import 'package:ai38re/viewmodel/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
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

  final picker = ImagePicker();
  File? _pickedImage;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final imageVm = context.read<ImageViewModel>();
      if (widget.id != null) {
        await context.read<ProductViewModel>().getProductById(widget.id);
        imageVm.setImageUrl(context.read<ProductViewModel>().product?.imageUrl);
      } else {
        imageVm.setImageUrl(null);
      }
    });
    super.initState();
  }

  Future<void> _pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    setState(() {
      _pickedImage = File(picked.path);
    });

    await context.read<ImageViewModel>().uploadImage(picked.path);
  }

  Widget _buildImagePreview(ImageViewModel imageVm) {
    if (imageVm.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_pickedImage != null) {
      return Image.file(_pickedImage!, fit: BoxFit.cover);
    }
    if (imageVm.imageUrl != null && imageVm.imageUrl!.isNotEmpty) {
      return Image.network(imageVm.imageUrl!, fit: BoxFit.cover);
    }
    return const Icon(Icons.add_a_photo, size: 40);
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductViewModel>();
    final imageVm = context.watch<ImageViewModel>();
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
          GestureDetector(
            onTap: imageVm.loading ? null : _pickImage,
            child: Container(
              height: 150,
              width: 150,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _buildImagePreview(imageVm),
            ),
          ),
          TextFormField(controller: nameController),
          TextFormField(controller: priceController),
          TextFormField(controller: descController),

          ElevatedButton(
            onPressed: () async {
              if (imageVm.loading) {
                Fluttertoast.showToast(msg: "Please wait, image is uploading");
                return;
              }
              if (widget.id == null) {
                //add
                final model = ProductModel(
                  id: "",
                  name: nameController.text,
                  price: double.parse(priceController.text),
                  description: descController.text,
                  imageUrl: imageVm.imageUrl,
                );
                final success = await vm.addProduct(model);
                if (success) {
                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(msg: vm.error.toString());
                }
              } else {
                //update
                final model = ProductModel(
                  id: widget.id,
                  name: nameController.text,
                  price: double.parse(priceController.text),
                  description: descController.text,
                  imageUrl: imageVm.imageUrl,
                );
                final success = await vm.updateProduct(model);
                if (success) {
                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(msg: vm.error.toString());
                }
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
