import 'shape_2d.dart';

/// Represents a triangle with a base and height.
class Triangle extends Shape2D {
  final double base;
  final double height;

  Triangle(this.base, this.height);

  @override
  double calculateArea() => (base * height) / 2;

  @override
  double calculatePerimeter() {
    // Assuming an equilateral triangle for simplicity.
    return 3 * base;
  }
}