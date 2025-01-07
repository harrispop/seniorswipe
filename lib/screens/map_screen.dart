import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../screens/models/item.dart';
import '../screens/data/items.dart';
import '../screens/utils/location_utils.dart';
import 'item_detail_screen.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}
LatLng randomLocation = LatLng(25.0418, 121.5331); // Example NTUT coordinates

class _MapScreenState extends State<MapScreen> {
  final LatLng ntutLocation = LatLng(25.042232, 121.535264); // NTUT location
  late Future<List<Item>> futureItems;

  final Map<String, Color> _categoryColors = {
    'Clothing': Colors.pinkAccent.withOpacity(0.5),
    'Textbooks': Colors.blueAccent.withOpacity(0.5),
    'Furniture': Colors.greenAccent.withOpacity(0.5),
    'Tutoring': Colors.orangeAccent.withOpacity(0.5),
    'Notes': Colors.purpleAccent.withOpacity(0.5),
  };

  @override
  void initState() {
    super.initState();
    futureItems = loadItems(); // Load items when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Item>>(
        future: futureItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No items available'));
          } else {
            final items = snapshot.data!;
            return Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    center: ntutLocation,
                    zoom: 13.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: items.map((item) {
                        final LatLng itemLocation = generateRandomLocation(ntutLocation, 15);
                        return Marker(
                          width: 80.0,
                          height: 80.0,
                          point: itemLocation,
                          builder: (ctx) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemDetailScreen(
                                    item: item,
                                    location: randomLocation, // Pass the correct location here
                                  ),
                                ),
                              );
                            },
                            child: Icon(Icons.location_on, color: _categoryColors[item.category], size: 30),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Container(
                    color: Colors.white70,
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _categoryColors.entries.map((entry) {
                        return Row(
                          children: [
                            Icon(Icons.location_on, color: entry.value, size: 20),
                            SizedBox(width: 8),
                            Text(entry.key, style: TextStyle(fontSize: 16)),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
