import 'package:ai38re/model/product_model.dart';
import 'package:ai38re/repo/product_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepoImpl implements ProductRepo {
  final collection = FirebaseFirestore.instance.collection("products");

  @override
  Future<void> addProduct(ProductModel model) async {
    final ref = collection.doc();
    model.id = ref.id;

    await ref.set(model.toMap());
  }

  @override
  Future<void> deleteproduct(String id) async {
    await collection.doc(id).delete();
  }

  @override
  Future<List<ProductModel>> filterProduct(double price) async{
    final data = await collection
        .where('price', isLessThanOrEqualTo: price)
        .get();

    List<ProductModel> products = [];

    for (int i = 0; i < data.docs.length; i++) {
      products.add(ProductModel.fromMap(data.docs[i].data()));
    }

    return products;
  }

  @override
  Future<List<ProductModel>> getAllProduct() async {
    final data = await collection.get();

    List<ProductModel> products = [];

    for (int i = 0; i < data.docs.length; i++) {
      products.add(ProductModel.fromMap(data.docs[i].data()));
    }

    return products;
  }

  @override
  Future<List<ProductModel>> getProductByCategory(String categoryId) async {
    final data = await collection
        .where('categoryId', isEqualTo: categoryId)
        .get();

    List<ProductModel> products = [];

    for (int i = 0; i < data.docs.length; i++) {
      products.add(ProductModel.fromMap(data.docs[i].data()));
    }

    return products;
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    final data = await collection.doc(id).get();
    final products = data.data();

    if (products == null) {
      throw Exception("Unable to load products");
    }
    return ProductModel.fromMap(products);
  }

  @override
  Future<List<ProductModel>> searchProduct(String name) {
    // TODO: implement searchProduct
    throw UnimplementedError();
  }

  @override
  Future<void> updateProduct(ProductModel model) async {
    await collection.doc(model.id).update(model.toMap());
  }
}
