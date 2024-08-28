import 'dart:math';
import 'shape_2d.dart';

/// Represents a circle with a radius.
class Circle extends Shape2D {
  final double radius;

  Circle(this.radius);

  @override
  double calculateArea() => pi * pow(radius, 2);

  @override
  double calculatePerimeter() => 2 * pi * radius;
}