// utils/location_utils.dart
import 'dart:math';
import 'package:latlong2/latlong.dart';

LatLng generateRandomLocation(LatLng center, double radiusInKm) {
  final random = Random();
  final double radiusInDegrees = radiusInKm / 111.32;

  final double u = random.nextDouble();
  final double v = random.nextDouble();
  final double w = radiusInDegrees * sqrt(u);
  final double t = 2 * pi * v;
  final double x = w * cos(t);
  final double y = w * sin(t);

  final double newX = x / cos(center.latitude);
  final double foundLongitude = newX + center.longitude;
  final double foundLatitude = y + center.latitude;

  return LatLng(foundLatitude, foundLongitude);
}