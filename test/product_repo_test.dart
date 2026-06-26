import 'package:ai38re/model/product_model.dart';
import 'package:ai38re/repo/product_repo_impl.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late ProductRepoImpl repo;

  // Runs before EVERY test, so each test starts with a clean, empty database.
  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    repo = ProductRepoImpl(firestore: fakeFirestore);
  });

  test('addProduct saves the product and gives it an id', () async {
    final product = ProductModel(name: 'Shoes', price: 50);

    await repo.addProduct(product);

    // The repo sets the id on the model after saving.
    expect(product.id, isNotNull);
    expect(product.id.runtimeType, String);

    // And the document really exists in the (fake) database.
    final saved = await fakeFirestore.collection('products').get();
    expect(saved.docs.length, 1);
    expect(saved.docs.first['name'], 'Shoes');
  });

  test('getAllProduct returns every product', () async {
    await repo.addProduct(ProductModel(name: 'Shoes', price: 50));
    await repo.addProduct(ProductModel(name: 'Hat', price: 10));

    final list = await repo.getAllProduct();

    expect(list.length, 2);
    expect(list.map((p) => p.name), containsAll(['Shoes', 'Hat']));
  });

  test('getAllProduct returns an empty list when there is nothing', () async {
    // await repo.addProduct(ProductModel(name: 'Shoes', price: 50));
    // await repo.addProduct(ProductModel(name: 'Hat', price: 10));

    final list = await repo.getAllProduct();
    expect(list, isEmpty);
  });

  test('getProductById returns the matching product', () async {
    final product = ProductModel(name: 'Bag', price: 99);
    await repo.addProduct(product); // this fills product.id

    final found = await repo.getProductById(product.id!);

    expect(found, isA<ProductModel>());
    expect(found.name, 'Bag');
  });

  test('getProductById throws when the id does not exist', () async {
    // NOTE: this repo THROWS for a missing id (see product_repo_impl.dart).
    expect(
      () => repo.getProductById('does-not-exist'),
      throwsException,
    );
  });

  test('updateProduct changes the saved values', () async {
    final product = ProductModel(name: 'Old name', price: 1);
    await repo.addProduct(product);

    product.name = 'New name';
    product.price = 999;
    await repo.updateProduct(product);

    final found = await repo.getProductById(product.id!);
    expect(found.name, 'New name');
    expect(found.price, 999);
  });

  test('deleteproduct removes the product', () async {
    final product = ProductModel(name: 'Shoes', price: 50);
    await repo.addProduct(product);

    await repo.deleteproduct(product.id!);

    final list = await repo.getAllProduct();
    expect(list, isEmpty);
  });

  test('filterProduct returns only products at or below the price', () async {
    await repo.addProduct(ProductModel(name: 'Cheap', price: 10));
    await repo.addProduct(ProductModel(name: 'Mid', price: 50));
    await repo.addProduct(ProductModel(name: 'Pricey', price: 200));

    final list = await repo.filterProduct(50); // price <= 50

    expect(list.length, 2);
  });

  test('getProductByCategory returns products of that category', () async {
    // ProductModel has no categoryId field, so we add docs directly to test it.
    await fakeFirestore.collection('products').add({
      'name': 'Phone',
      'categoryId': 'electronics',
    });
    await fakeFirestore.collection('products').add({
      'name': 'Shirt',
      'categoryId': 'clothes',
    });

    final list = await repo.getProductByCategory('electronics');

    expect(list.length, 1);
  });


}
