import 'dart:math';
import 'shape_3d.dart';

/// Represents a cube with a side length.
class Cube extends Shape3D {
  final double side;

  Cube(this.side);

  @override
  double calculateVolume() => pow(side, 3).toDouble();

  @override
  double calculateSurfaceArea() => 6 * pow(side, 2).toDouble();
}