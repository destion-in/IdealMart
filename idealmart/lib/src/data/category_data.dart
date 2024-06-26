// data.dart

class Category {
  final String name;
  final String imageUrl;

  Category({required this.name, required this.imageUrl});
}

List<Category> categories = [
  Category(
      name: 'Bakery',
      imageUrl: 'https://cdn-icons-png.flaticon.com/128/541/541732.png'),
  Category(
      name: 'Fruits',
      imageUrl: 'https://cdn-icons-png.flaticon.com/128/2892/2892338.png'),
  Category(
      name: 'Vegetables',
      imageUrl: 'https://cdn-icons-png.flaticon.com/128/10632/10632405.png'),
  Category(
      name: 'Dairy',
      imageUrl: 'https://cdn-icons-png.flaticon.com/128/2674/2674505.png'),
  Category(
      name: 'Meat',
      imageUrl: 'https://cdn-icons-png.flaticon.com/128/5029/5029127.png'),
  Category(
      name: 'Grocery',
      imageUrl: 'https://cdn-icons-png.flaticon.com/128/3514/3514218.png')
];
