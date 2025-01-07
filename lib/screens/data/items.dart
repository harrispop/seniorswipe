// data/items.dart
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/item.dart';

Future<List<Item>> loadItems() async {
  final data = await rootBundle.loadString('assets/data/listings.txt');
  final List<Item> items = [];
  final lines = LineSplitter.split(data).toList();

  String category = '';
  int id = 0;

  for (int i = 0; i < lines.length; i++) {
    final line = lines[i].trim();
    if (line.startsWith('Category: ')) {
      category = line.substring('Category: '.length).trim();
    } else if (line.contains('**Name**: ')) {
      final name = line.split('**Name**: ')[1].trim();
      final description = lines[i + 1].split('**Description**: ')[1].trim();
      final priceText = lines[i + 2].split('**Price**: \$')[1].trim();
      final price = double.parse(priceText.split(' ')[0]);
      final distanceText = lines[i + 3].split('**Distance**: ')[1].trim();
      final distance = double.parse(distanceText.split(' ')[0]);

      // Use predefined images based on category
      final imageUrl = 'assets/images/${category.toLowerCase()}.png';

      // Generate a random average rating between 1.0 and 5.0
      final avgRating = (1 + (4 * (id % 5 + 1) / 5)).toStringAsFixed(1);

      items.add(Item(
        id: id++,
        name: name,
        imageUrl: imageUrl,
        price: price,
        distance: distance,
        owner: 'User $id',
        ratings: (id % 5) + 1,
        avgRating: avgRating, // Add avgRating parameter
        description: description,
        category: category,
      ));
    }
  }

  print('Total items loaded: ${items.length}'); // Debug print
  return items;
}