import 'shape_2d.dart';

/// Represents a rectangle with a width and height.
class Rectangle extends Shape2D {
  final double width;
  final double height;

  Rectangle(this.width, this.height);

  @override
  double calculateArea() => width * height;

  @override
  double calculatePerimeter() => 2 * (width + height);
}