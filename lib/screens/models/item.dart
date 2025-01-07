import 'dart:math';

class Item {
  final int id;
  final String name;
  final String imageUrl;
  final double price;
  final double distance;
  final String owner;
  final int ratings;
  final String avgRating;
  final String description;
  final String category;

  Item({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.distance,
    required this.owner,
    required this.ratings,
    required this.avgRating,
    required this.description,
    required this.category,
  });

  static String generateRandomRating() {
    final random = Random();
    final rating = 4.3 + (random.nextInt(15) * 0.05);
    return rating.toStringAsFixed(2);
  }

  static String generateRandomOwner(List<String> names) {
    final random = Random();
    return names[random.nextInt(names.length)];
  }

  factory Item.generateItem(int id, String name, String imageUrl, double price, double distance, String description, String category, List<String> names) {
    return Item(
      id: id,
      name: name,
      imageUrl: imageUrl,
      price: price,
      distance: distance,
      owner: generateRandomOwner(names),
      ratings: Random().nextInt(5) + 1, // Random ratings between 1 and 5
      avgRating: generateRandomRating(),
      description: description,
      category: category,
    );
  }
}