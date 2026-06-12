import 'package:ai38re/model/product_model.dart';
import 'package:ai38re/repo/product_repo.dart';
import 'package:flutter/material.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepo _productRepo;

  ProductViewModel({required ProductRepo productRepo})
    : _productRepo = productRepo;

  bool _loading = false;

  bool get loading => _loading;

  String? _error;

  String? get error => _error;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setError(String? value) {
    _error = value;
    notifyListeners();
  }

  //getProductById
  ProductModel? _product;

  ProductModel? get product => _product;

  //getAllProduct
  List<ProductModel>? _allProducts;

  List<ProductModel>? get allProducts => _allProducts;

  //getProductByCategory
  List<ProductModel>? _categoryProducts;

  List<ProductModel>? get categoryProducts => _categoryProducts;

  //filterProducts
  List<ProductModel>? _filterProducts;

  List<ProductModel>? get filterProducts => _filterProducts;

  //searchProduct
  List<ProductModel>? _searchProducts;

  List<ProductModel>? get searchProducts => _searchProducts;

  Future<bool> addProduct(ProductModel model) async {
    setLoading(true);
    setError(null);
    try {
      await _productRepo.addProduct(model);
      return true;
    } on Exception catch (e) {
      setError(e.toString());
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<bool> deleteproduct(String id) async{
    setLoading(true);
    setError(null);
    try {
      await _productRepo.deleteproduct(id);
      return true;
    } on Exception catch (e) {
      setError(e.toString());
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<bool> updateProduct(ProductModel model) async{
    setLoading(true);
    setError(null);
    try {
      await _productRepo.updateProduct(model);
      return true;
    } on Exception catch (e) {
      setError(e.toString());
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<void> getProductById(String id) async{
    setLoading(true);
    setError(null);
    try {
      _product = await _productRepo.getProductById(id);
    } on Exception catch (e) {
      setError(e.toString());
    }finally{
      setLoading(false);
    }
  }

  Future<void> getAllProduct() {}

  Future<void> getProductByCategory(String categoryId) {}

  Future<void> searchProduct(String name) {}

  Future<void> filterProduct(double price) {}
}
