import 'package:ai38re/model/product_model.dart';

abstract class ProductRepo {

  Future<void> addProduct(ProductModel model);

  Future<void> deleteproduct(String id);

  Future<void> updateProduct(ProductModel model);

  Future<ProductModel> getProductById(String id);

  Future<List<ProductModel>> getAllProduct();

  Future<List<ProductModel>> getProductByCategory(String categoryId);

  Future<List<ProductModel>> searchProduct(String name);

  Future<List<ProductModel>> filterProduct(double price);
}