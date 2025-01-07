import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/item.dart';

Future<List<Item>> loadItems() async {
  try {
    print('Loading listings.txt file...');
    final String response = await rootBundle.loadString('assets/data/listings.txt');
    print('File loaded successfully.');

    final List<Item> items = [];
    final List<String> lines = LineSplitter().convert(response);

    String? category;
    int id = 0;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i].trim();
      print('Processing line: $line');

      if (line.startsWith('Category: ')) {
        category = line.substring(10).trim();
        print('Category found: $category');
      } else if (line.startsWith('**Name**:')) {
        final name = line.split('**Name**: ')[1].trim();
        print('Name found: $name');

        if (i + 3 < lines.length) {
          final description = lines[++i].split('**Description**: ')[1].trim();
          print('Description found: $description');

          String priceString = lines[++i].split('**Price**: ')[1].trim();
          double price;
          if (priceString.contains('per hour')) {
            price = double.parse(priceString.split(' ')[0].replaceFirst('\$', ''));
          } else {
            price = double.parse(priceString.replaceFirst('\$', ''));
          }
          print('Price found: $price');

          final distance = double.parse(lines[++i].split('**Distance**: ')[1].split(' miles')[0].trim());
          print('Distance found: $distance');

          // Generate a random average rating between 1.0 and 5.0
          final avgRating = (1 + (4 * (id % 5 + 1) / 5)).toStringAsFixed(1);

          items.add(Item(
            id: id,
            name: name,
            description: description,
            price: price,
            distance: distance,
            owner: 'User $id',
            ratings: 5, // Assuming all items have 5-star ratings for simplicity
            avgRating: avgRating, // Add avgRating parameter
            imageUrl: 'assets/items/${category?.toLowerCase() ?? 'unknown'}$id.png', // Assuming images are named by category and id
            category: category ?? 'Unknown',
          ));
          print('Added item: $name');
          id++;
        }
      }
    }

    print('Parsed ${items.length} items.');
    return items;
  } catch (e) {
    print('Error parsing listings: $e');
    throw Exception('Error parsing listings');
  }
}