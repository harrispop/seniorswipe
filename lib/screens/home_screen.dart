import 'package:flutter/material.dart';
import '../screens/models/item.dart';
import '../screens/widgets/swipe_card.dart';
import 'dart:math';

class HomeScreen extends StatelessWidget {
  final List<Item> swipeItems;

  HomeScreen({Key? key})
      : swipeItems = List.generate(
    20,
        (index) => Item(
      id: index,
      name: getItemName(index),
      imageUrl: 'assets/items/item${index}-resized.png',
      price: getItemPrice(index),
      distance: generateRandomDistance(),
      owner: generateUniqueUserName(index),
      ratings: Random().nextInt(100) + 1,
      avgRating: (Random().nextDouble() * 5).toStringAsFixed(1),
      description: getItemDescription(index),
      category: getItemCategory(index),
    ),
  )..shuffle(Random()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SwipeCard(items: swipeItems),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

              ],
            ),
          ),
        ],
      ),
    );
  }

  static String getItemName(int index) {
    switch (index) {
      case 0: return 'Old Red Hat';
      case 1: return 'Desk Lamp';
      case 2: return 'Polish Tutoring - 10 hours';
      case 3: return 'Broken Chair';
      case 4: return 'Skateboard';
      case 5: return 'Big Data Notes';
      case 6: return 'Coding 101 Exam Prep - 2 hours';
      case 7: return 'Anatomy 101 Book';
      case 8: return 'Mizuno Wave Momentum 2';
      case 9: return 'S-works Tarmac SL6, Shimano';
      case 10: return 'Shoei x15';
      case 11: return 'Psychology Notes';
      case 12: return 'Math Notes';
      case 13: return 'Tutoring Psychology - 5 hours';
      case 14: return 'Chemical Engineering Tutoring - 2 hours';
      case 15: return 'How to Win Friends - Used Paperback Book';
      case 16: return 'Used NTU Hoodie';
      case 17: return 'Physics Notes';
      case 18: return 'Big Computer Desk';
      case 19: return 'ACT Cliff Notes';
      default: return 'Item $index';
    }
  }

  static double getItemPrice(int index) {
    switch (index) {
      case 0: return 10.0;
      case 1: return 5.0;
      case 2: return 100.0;
      case 3: return 1.0;
      case 4: return 40.0;
      case 5: return 20.0;
      case 6: return 35.0;
      case 7: return 29.0;
      case 8: return 50.0;
      case 9: return 300.0;
      case 10: return 200.0;
      case 11: return 10.0;
      case 12: return 20.0;
      case 13: return 70.0;
      case 14: return 10.0;
      case 15: return 12.0;
      case 16: return 45.0;
      case 17: return 4.0;
      case 18: return 30.0;
      case 19: return 5.0;
      default: return 0.0;
    }
  }

  static String getItemDescription(int index) {
    return 'This is a description of ${getItemName(index)}.';
  }

  static String getItemCategory(int index) {
    switch (index) {
      case 0:
      case 16:
        return 'Clothing';
      case 1:
      case 18:
        return 'Furniture';
      case 2:
      case 13:
        return 'Service';
      case 3:
      case 17:
        return 'Education';
      case 4:
      case 8:
      case 9:
      case 10:
        return 'Sports';
      case 5:
      case 6:
      case 7:
      case 11:
      case 12:
      case 19:
        return 'Education';
      case 15:
        return 'Books';
      default:
        return 'Miscellaneous';
    }
  }

  static double generateRandomDistance() {
    final random = Random();
    double distance;
    do {
      distance = random.nextDouble() * 23;
    } while ((distance % 5).round() == 0);
    return double.parse(distance.toStringAsFixed(1));
  }

  static String generateUniqueUserName(int index) {
    const names = [
      'John Doe',
      'Jane Smith',
      'Alice Johnson',
      'Bob Brown',
      'Charlie Davis',
      'Emily White',
      'Frank Green',
      'Grace Black',
      'Henry Blue',
      'Ivy Gold',
    ];
    return names[index % names.length] + ' ${index ~/ names.length}';
  }
}