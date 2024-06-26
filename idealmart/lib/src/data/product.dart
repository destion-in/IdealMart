class Product {
  final int uid;
  final String productId;
  final String name;
  final String category;
  final String brand;
  final double price;
  final double discountPrice;
  final String? productDescription;
  final String quantity;
  final String measurementType;
  final String storeId;
  final String validFrom;
  final String validTo;

  Product({
    required this.uid,
    required this.productId,
    required this.name,
    required this.category,
    required this.brand,
    required this.price,
    required this.discountPrice,
    this.productDescription,
    required this.quantity,
    required this.measurementType,
    required this.storeId,
    required this.validFrom,
    required this.validTo,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      uid: json['uid'],
      productId: json['productId'],
      name: json['name'],
      category: json['category'],
      brand: json['brand'],
      price: double.parse(json['price']),
      discountPrice: double.parse(json['discountPrice']),
      productDescription: json['productDescription'],
      quantity: json['quantity'],
      measurementType: json['measurementType'],
      storeId: json['storeId'],
      validFrom: json['validFrom'],
      validTo: json['validTo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'productId': productId,
      'name': name,
      'category': category,
      'brand': brand,
      'price': price.toString(),
      'discountPrice': discountPrice.toString(),
      'productDescription': productDescription,
      'quantity': quantity,
      'measurementType': measurementType,
      'storeId': storeId,
      'validFrom': validFrom,
      'validTo': validTo,
    };
  }
}
