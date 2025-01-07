import 'package:flutter/material.dart';
import 'dart:async';
import 'landing_screen.dart';
import 'utils/interaction_utils.dart'; // Import the InteractionUtils class

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _opacityAnimation;
  Animation<double>? _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Preload the sound and start animation only after the sound is loaded
    InteractionUtils.preloadSound('swoosh.mp3').then((_) {
      _controller = AnimationController(
        duration: const Duration(seconds: 2),
        vsync: this,
      );

      _opacityAnimation = CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeIn,
      );

      _scaleAnimation = Tween<double>(begin: 0.5, end: 1.2).animate(
        CurvedAnimation(
          parent: _controller!,
          curve: Curves.easeInOut,
        ),
      );

      // Play the sound when the animation starts at a lower volume
      InteractionUtils.playSound('swoosh.mp3', volume: 0.1);

      // Start the animation
      _controller!.forward();

      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => LandingScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation ?? AlwaysStoppedAnimation(0.0),
          child: ScaleTransition(
            scale: _scaleAnimation ?? AlwaysStoppedAnimation(1.0),
            child: Image.asset('assets/logo.png', height: 200),
          ),
        ),
      ),
    );
  }
}