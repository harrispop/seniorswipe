import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../screens/models/item.dart';
import '../screens/data/items.dart';
import 'item_detail_screen.dart';

class ExploreTab extends StatefulWidget {
  @override
  _ExploreTabState createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  late Future<List<Item>> _futureItems;
  String? _selectedCategory = 'Any'; // Default to "Any"
  String _searchTerm = '';
  double _minSliderPrice = 0.0;
  double _maxSliderPrice = 1000.0;
  double _minPrice = 0.0;
  double _maxPrice = 1000.0;
  String _sortOption = 'None';

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
    _futureItems = loadItems();
    _futureItems.then((items) {
      if (items.isNotEmpty) {
        setState(() {
          _minSliderPrice =
              items.map((item) => item.price).reduce((a, b) => a < b ? a : b);
          _maxSliderPrice =
              items.map((item) => item.price).reduce((a, b) => a > b ? a : b);
          _minPrice = _minSliderPrice;
          _maxPrice = _maxSliderPrice;
        });
      }
    });
  }

  List<Item> _filterItems(List<Item> items) {
    List<Item> filteredItems = items;

    if (_selectedCategory != null && _selectedCategory != 'Any') {
      filteredItems =
          filteredItems.where((item) => item.category == _selectedCategory)
              .toList();
    }

    if (_searchTerm.isNotEmpty) {
      filteredItems = filteredItems.where((item) =>
          item.name.toLowerCase().contains(_searchTerm.toLowerCase())).toList();
    }

    filteredItems = filteredItems.where((item) => item.price >= _minPrice &&
        item.price <= _maxPrice).toList();

    switch (_sortOption) {
      case 'Price Asc':
        filteredItems.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price Desc':
        filteredItems.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Distance Asc':
        filteredItems.sort((a, b) => a.distance.compareTo(b.distance));
        break;
      case 'Distance Desc':
        filteredItems.sort((a, b) => b.distance.compareTo(a.distance));
        break;
    }

    return filteredItems;
  }

  // Inside the _ExploreTabState widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        automaticallyImplyLeading: false, // Removes the back arrow
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filters Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Categories Dropdown
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Categories', style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                      SizedBox(
                        width: 120, // Adjust width to your preference
                        child: DropdownButton<String>(
                          value: _selectedCategory,
                          isExpanded: true,
                          icon: Icon(Icons.category),
                          underline: Container(height: 1, color: Colors.grey),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCategory = newValue;
                            });
                          },
                          items: ['Any', ..._categoryColors.keys].map((
                              String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 16), // Space between filters

                  // Sort By Dropdown
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Sort By:', style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                      SizedBox(
                        width: 120, // Adjust width to your preference
                        child: DropdownButton<String>(
                          value: _sortOption,
                          isExpanded: true,
                          icon: Icon(Icons.sort),
                          underline: Container(height: 1, color: Colors.grey),
                          onChanged: (String? newValue) {
                            setState(() {
                              _sortOption = newValue!;
                            });
                          },
                          items: <String>[
                            'None',
                            'Price Asc',
                            'Price Desc',
                            'Distance Asc',
                            'Distance Desc'
                          ]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 16), // Space between filters

                  // Price Range Slider
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price Range', style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                      SizedBox(
                        width: 220, // Adjust width for slider
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('\$${_minPrice.toStringAsFixed(0)}'),
                                Text('\$${_maxPrice.toStringAsFixed(0)}'),
                              ],
                            ),
                            RangeSlider(
                              values: RangeValues(_minPrice, _maxPrice),
                              min: _minSliderPrice,
                              max: _maxSliderPrice,
                              onChanged: (RangeValues values) {
                                setState(() {
                                  _minPrice = values.start;
                                  _maxPrice = values.end;
                                });
                              },
                              labels: RangeLabels(
                                '\$${_minPrice.toStringAsFixed(0)}',
                                '\$${_maxPrice.toStringAsFixed(0)}',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search by name',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchTerm = value;
                });
              },
            ),
          ),

          // Items List
          Expanded(
            child: FutureBuilder<List<Item>>(
              future: _futureItems,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error loading listings'));
                } else {
                  final items = _filterItems(snapshot.data!);

                  if (items.isEmpty) {
                    return Center(child: Text('No items found'));
                  }

                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        leading: Container(
                          width: 24,
                          height: 24,
                          color: _categoryColors[item.category],
                          child: Image.asset(
                              item.imageUrl, fit: BoxFit.contain),
                        ),
                        title: Text(item.name),
                        subtitle: Text(item.category == 'Tutoring' ? '\$${item
                            .price} per hour' : '\$${item.price}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              ItemDetailScreen(
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
          ),
        ],
      ),
    );
  }
}