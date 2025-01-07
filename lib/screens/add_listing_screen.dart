import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../screens/models/item.dart';
import 'dart:io';

class AddListingScreen extends StatefulWidget {
  final Function(Item) onAddItem;

  AddListingScreen({required this.onAddItem});

  @override
  _AddListingScreenState createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _addItem() {
    final item = Item(
      id: DateTime.now().millisecondsSinceEpoch, // Unique ID
      name: _nameController.text,
      imageUrl: _imageFile?.path ?? 'assets/my_items/default.png', // Use the file path if the image is picked
      price: double.parse(_priceController.text),
      distance: 0.0,
      owner: 'Me',
      ratings: 0,
      avgRating: '0.0', // Default avgRating
      description: _descriptionController.text,
      category: 'Misc',
    );
    widget.onAddItem(item);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Listing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            _imageFile != null
                ? Image.file(_imageFile!, width: 300, height: 200, fit: BoxFit.cover)
                : Placeholder(fallbackHeight: 200.0, fallbackWidth: double.infinity),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Add Photo'),
            ),
            ElevatedButton(
              onPressed: _addItem,
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}