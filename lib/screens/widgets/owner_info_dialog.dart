import 'package:flutter/material.dart';

class OwnerInfoDialog extends StatelessWidget {
  final String ownerName;
  final int listingsCount;
  final int ratingsCount;
  final String avgRating;
  final VoidCallback onSendMessage;

  OwnerInfoDialog({
    required this.ownerName,
    required this.listingsCount,
    required this.ratingsCount,
    required this.avgRating,
    required this.onSendMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              ownerName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Listings',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '$listingsCount',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Ratings',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '$ratingsCount',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Avg Rating',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '$avgRating',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onSendMessage,
              child: Text('Send Message'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}