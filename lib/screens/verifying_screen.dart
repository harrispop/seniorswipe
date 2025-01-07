// Fake verify screen for funsies

import 'package:flutter/material.dart';
import '../main.dart';

class VerifyingScreen extends StatefulWidget {
  final String name;
  final String university;

  VerifyingScreen({required this.name, required this.university});

  @override
  _VerifyingScreenState createState() => _VerifyingScreenState();
}

class _VerifyingScreenState extends State<VerifyingScreen> {
  bool _isVerifying = true;

  @override
  void initState() {
    super.initState();
    // Simulate a delay for verification
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isVerifying = false;
      });
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(
              name: widget.name,
              university: widget.university,
            ),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isVerifying
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Verifying...'),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check_circle, color: Colors.green, size: 100),
            SizedBox(height: 20),
            Text('Verification Complete!'),
          ],
        ),
      ),
    );
  }
}