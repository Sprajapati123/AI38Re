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
      await getAllProduct();
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
      await getAllProduct();
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
      await getAllProduct();
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

  Future<void> getAllProduct() async{
    setLoading(true);
    setError(null);
    try {
      _allProducts = await _productRepo.getAllProduct();
    } on Exception catch (e) {
      setError(e.toString());
    }finally{
      setLoading(false);
    }
  }

  Future<void> getProductByCategory(String categoryId) async{
    setLoading(true);
    setError(null);
    try {
      _categoryProducts = await _productRepo.getProductByCategory(categoryId);
    } on Exception catch (e) {
      setError(e.toString());
    }finally{
      setLoading(false);
    }
  }

  Future<void> searchProduct(String name) async{
    setLoading(true);
    setError(null);
    try {
      _searchProducts = await _productRepo.searchProduct(name);
    } on Exception catch (e) {
      setError(e.toString());
    }finally{
      setLoading(false);
    }
  }

  Future<void> filterProduct(double price) async{
    setLoading(true);
    setError(null);
    try {
      _filterProducts = await _productRepo.filterProduct(price);
    } on Exception catch (e) {
      setError(e.toString());
    }finally{
      setLoading(false);
    }
  }
}
