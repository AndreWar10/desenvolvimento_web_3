import 'dart:math';
import 'shape_3d.dart';

/// Represents a cone with a radius and height.
class Cone extends Shape3D {
  final double radius;
  final double height;

  Cone(this.radius, this.height);

  @override
  double calculateVolume() => (1 / 3) * pi * pow(radius, 2) * height;

  @override
  double calculateSurfaceArea() {
    double slantHeight = sqrt(pow(radius, 2) + pow(height, 2));
    return pi * radius * (radius + slantHeight);
  }
}