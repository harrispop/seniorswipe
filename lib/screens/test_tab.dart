// this is a test tab while I was fixing explore
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../screens/models/item.dart';
import '../screens/data/items.dart';
import 'item_detail_screen.dart';

class TestTab extends StatefulWidget {
  @override
  _TestTabState createState() => _TestTabState();
}

class _TestTabState extends State<TestTab> {
  late Future<List<Item>> futureItems;

  @override
  void initState() {
    super.initState();
    futureItems = loadItems(); // Load items when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Tab'),
      ),
      body: FutureBuilder<List<Item>>(
        future: futureItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Show error message if there's an error
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available')); // Show message if no data is found
          } else {
            final items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: Image.asset(
                    item.imageUrl,
                    fit: BoxFit.contain,
                    width: 50,
                    height: 50,
                  ), // Display item image
                  title: Text(item.name),
                  subtitle: Text('${item.category} - \$${item.price.toStringAsFixed(2)}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetailScreen(
                      item: item,
                      location: LatLng(25.0418, 121.5331), // Default location (NTUT coordinates),
                      ),
                    ));
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}