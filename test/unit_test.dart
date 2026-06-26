// ============================================================
//  UNIT TEST  =  test plain logic (no screen, no buttons)
// ============================================================
//
// Run it with:   flutter test test/unit_test.dart
//
// Every test has 3 simple steps:
//   1. make something
//   2. call the thing you want to check
//   3. expect(actual, whatYouExpect)

import 'package:ai38re/model/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ProductModel keeps the name we gave it', () {
    // 1. make a product
    final product = ProductModel(name: 'Shoes', price: 50);

    // 2 + 3. check its values
    expect(product.name, 'Shoes');
    expect(product.price, 50);
  });

  test('toMap() puts the values into a map', () {
    final product = ProductModel(name: 'Hat', price: 10);

    final map = product.toMap();

    expect(map['name'], 'Hat');
    expect(map['price'], 10);
  });
}
