import 'package:ai38re/view/add_product_screen.dart';
import 'package:ai38re/viewmodel/product_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().getAllProduct();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductViewModel>();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ManageProductScreen()),
          );
        },
        icon: Icon(Icons.add),
        label: Text("Add Products"),
      ),
      body: vm.loading
          ? CircularProgressIndicator()
          : vm.allProducts == null
          ? Text("No products")
          : ListView.builder(
              itemCount: vm.allProducts!.length,
              itemBuilder: (context, index) {
                final data = vm.allProducts![index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          height: 100,width: 100,
                          imageUrl: data.imageUrl.toString(),
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${data.name}"),
                            Text("${data.price}"),
                            Text("${data.description}"),

                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ManageProductScreen(id: data.id.toString()),
                                  ),
                                );
                              },
                              child: Text("Edit"),
                            ),
                            TextButton(
                              onPressed: () async {
                                await vm.deleteproduct(data.id.toString());
                              },
                              child: Text("Delete"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
