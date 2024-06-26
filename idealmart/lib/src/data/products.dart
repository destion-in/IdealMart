class Product {
  final String imageUrl;
  final String productName;
  final double price;
  final double? offerPrice;

  Product({
    required this.imageUrl,
    required this.productName,
    required this.price,
    this.offerPrice,
  });
}

List<Product> popularProducts = [
  Product(
    imageUrl: 'https://cdn-icons-png.flaticon.com/128/415/415733.png',
    productName: 'Apples',
    price: 4.0,
    offerPrice: 5.0,
  ),
  Product(
    imageUrl: 'https://cdn-icons-png.flaticon.com/128/11159/11159127.png',
    productName: 'Bananas',
    price: 3.0,
    offerPrice: 3.5,
  ),
  Product(
    imageUrl: 'https://cdn-icons-png.flaticon.com/128/3136/3136973.png',
    productName: 'Carrots',
    price: 2.5,
    offerPrice: 3.0,
  ),
  // Add more popular products
];

List<Product> latestProducts = [
  Product(
    imageUrl: 'https://cdn-icons-png.flaticon.com/128/6409/6409458.png',
    productName: 'Broccoli',
    price: 2.0,
  ),
  Product(
    imageUrl: 'https://cdn-icons-png.flaticon.com/128/5564/5564721.png',
    productName: 'Rice',
    price: 3.0,
    offerPrice: 3.5,
  ),
  Product(
    imageUrl: 'https://cdn-icons-png.flaticon.com/128/10634/10634001.png',
    productName: 'Milk',
    price: 1.5,
  ),
  // Add more latest products
];
