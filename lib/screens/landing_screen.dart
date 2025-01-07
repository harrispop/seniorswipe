import 'package:flutter/material.dart';
import 'registration_screen.dart';
import 'utils/interaction_utils.dart'; // Import the InteractionUtils class

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _loginMessage = '';
  String _logoPath = 'assets/logo.png';
  bool _easterEggTriggered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _easterEggTriggered ? Colors.black : Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(_logoPath, height: 200),
            SizedBox(height: 20),
            Container(
              width: 300,
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Username',
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 300,
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Password',
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: _handleLogin,
                child: Text('Login'),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationScreen()),
                  );
                },
                child: Text('Register'),
              ),
            ),
            SizedBox(height: 20),
            if (_loginMessage.isNotEmpty)
              Text(
                _loginMessage,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }

  void _handleLogin() {
    if (_usernameController.text == 'tymek' && _passwordController.text.isEmpty && !_easterEggTriggered) {
      setState(() {
        _logoPath = 'assets/logored.png';
        _loginMessage = '';
        _easterEggTriggered = true;
      });
      InteractionUtils.playSound('poland.mp3', volume: 1.0); // Play at 100% volume
    } else {
      setState(() {
        _loginMessage = 'Logins are not supported in this demo - try registering!';
      });
    }
  }
}