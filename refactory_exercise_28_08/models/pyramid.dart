import 'dart:math';
import 'shape_3d.dart';

/// Represents a pyramid with a base and height.
class Pyramid extends Shape3D {
  final double baseLength;
  final double baseWidth;
  final double height;

  Pyramid(this.baseLength, this.baseWidth, this.height);

  @override
  double calculateVolume() => (1 / 3) * baseLength * baseWidth * height;

  @override
  double calculateSurfaceArea() {
    double slantHeight = sqrt(pow(baseLength / 2, 2) + pow(height, 2));
    double baseArea = baseLength * baseWidth;
    double lateralArea = (baseLength + baseWidth) * slantHeight;
    return baseArea + lateralArea;
  }
}