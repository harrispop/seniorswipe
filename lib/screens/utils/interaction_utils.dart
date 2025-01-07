import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

class InteractionUtils {
  static final AudioCache _audioCache = AudioCache(prefix: 'assets/sounds/');

  // Method to trigger haptic feedback
  static void triggerHapticFeedback() {
    HapticFeedback.lightImpact();
  }

  // Method to preload a sound
  static Future<void> preloadSound(String soundFileName) async {
    await _audioCache.load(soundFileName);
  }

  // Method to play a sound at specified volume
  static void playSound(String soundFileName, {double volume = 1.0}) {
    _audioCache.play(
      soundFileName,
      volume: volume,
    );
  }
}