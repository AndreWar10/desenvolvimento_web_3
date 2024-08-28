import 'dart:math';
import 'shape_3d.dart';

/// Represents a cylinder with a radius and height.
class Cylinder extends Shape3D {
  final double radius;
  final double height;

  Cylinder(this.radius, this.height);

  @override
  double calculateVolume() => pi * pow(radius, 2) * height;

  @override
  double calculateSurfaceArea() {
    return 2 * pi * radius * (radius + height);
  }
}