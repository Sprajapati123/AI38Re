class ProductModel {
  String? id;
  String? name;
  double? price;
  String? description;
  String? imageUrl;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.description,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'price': this.price,
      'description': this.description,
      'imageUrl': this.imageUrl,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String?,
      name: map['name'] as String?,
      price: (map['price'] as num?)?.toDouble(),
      description: map['description'] as String?,
      imageUrl: map['imageUrl'] as String?,
    );
  }

}