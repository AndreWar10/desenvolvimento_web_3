import 'dart:math';
import 'shape_3d.dart';

/// Represents a sphere with a radius.
class Sphere extends Shape3D {
  final double radius;

  Sphere(this.radius);

  @override
  double calculateVolume() => (4 / 3) * pi * pow(radius, 3).toDouble();

  @override
  double calculateSurfaceArea() => 4 * pi * pow(radius, 2).toDouble();
}