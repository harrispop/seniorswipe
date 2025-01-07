import 'package:flutter/material.dart';
import 'screens/map_screen.dart';
import 'screens/landing_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_tab.dart';
import 'screens/explore_tab.dart';
import 'screens/messages_screen.dart';
import 'screens/add_listing_screen.dart';
import 'screens/message_compose_screen.dart';
import 'screens/test_tab.dart'; // Import the new test tab
import 'screens/item_detail_screen.dart'; // Import the item detail screen
import 'screens/utils/interaction_utils.dart'; // Import the utility file
import 'screens/splash_screen.dart'; // Import the splash screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniSwap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  final String name;
  final String university;

  MainScreen({required this.name, required this.university});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2; // Set the default index to HomeScreen

  static List<Widget> _widgetOptions = <Widget>[
    MapScreen(), // Map tab
    ExploreTab(), // Explore tab
    HomeScreen(), // Home tab (center)
    MessagesScreen(), // Messages tab
    ProfileTab(), // Profile tab
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    InteractionUtils.playSound('button_click.mp3', volume: 0.05); // Play sound on navigation item tap
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 30,
            ),
            SizedBox(width: 10),
            Text('Welcome ${widget.name}!'),
            Spacer(),
            TextButton(
              onPressed: () {
                // Navigate to the start screen
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
              child: Text(
                'DEMO APP - START OVER',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false, // This removes the back button
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey, // Set unselected item color to grey
        onTap: _onItemTapped,
      ),
    );
  }
}