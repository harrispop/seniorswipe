import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Ensure correct import
import '../screens/models/item.dart';

class ItemDetailScreen extends StatelessWidget {
  final Item item;
  final LatLng location;

  ItemDetailScreen({required this.item, required this.location});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                child: FlutterMap(
                  options: MapOptions(
                    center: location, // Use the specific item's location here
                    zoom: 15,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: location,
                          builder: (ctx) => Container(
                            child: Icon(Icons.location_on, color: Colors.blue, size: 40),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Image.asset(item.imageUrl, fit: BoxFit.contain, width: 40, height: 40),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Category: ${item.category}',
                          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Description: ${item.description}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Distance: ${item.distance.toStringAsFixed(1)} miles',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Price: \$${item.price.toStringAsFixed(2)}${item.category == 'Tutoring' ? ' per hour' : ''}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
