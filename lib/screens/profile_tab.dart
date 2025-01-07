// This is the profile tab where your listings are

import 'package:flutter/material.dart';
import '../screens/models/item.dart';
import 'add_listing_screen.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final List<Item> myItems = [
    Item(
      id: 0,
      name: 'E-Commerce Notes',
      imageUrl: 'assets/my_items/item0.png',
      price: 25.0,
      description: "Notes for Dr. Gordon's E-Commerce class at NTUT!",
      category: 'Books',
      distance: 1,
      owner: "N/A",
      ratings:0,
      avgRating:"5",


    ),
    Item(
      id: 1,
      name: 'Minnesota Vikings Hat',
      imageUrl: 'assets/my_items/item1.png',
      price: 10.0,
      description: 'Heavily used, good quality',
      category: 'Clothing',
      distance: 1,
      owner: "N/A",
      ratings:0,
      avgRating:"5",
    ),
  ];

  void _addItem(Item item) {
    setState(() {
      myItems.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Icon(
                Icons.person,
                color: Colors.grey[600],
              ),
            ),
            title: Text('My Profile'),
            onTap: () {
              // Navigate to profile editing screen
            },
          ),
          Divider(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: myItems.length,
              itemBuilder: (context, index) {
                return _buildItemCard(myItems[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 60,
              height: 60,
              child: FloatingActionButton(
                onPressed: () {
                  // Navigate to AddListingScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddListingScreen(onAddItem: _addItem),
                    ),
                  );
                },
                child: Icon(Icons.add, size: 30),
                backgroundColor: Colors.blue,
                elevation: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(Item item) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(item.name),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(item.imageUrl),
                  SizedBox(height: 8),
                  Text(item.description),
                  SizedBox(height: 8),
                  Text('Category: ${item.category}'),
                  SizedBox(height: 8),
                  Text('Price: \$${item.price}'),
                ],
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                item.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('\$${item.price}',
                      style: TextStyle(color: Colors.green[700])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}