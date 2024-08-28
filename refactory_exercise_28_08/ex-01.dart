import 'dart:io';
import './models/rectangle.dart';
import './models/circle.dart';
import './models/cone.dart';
import './models/cube.dart';
import './models/cylinder.dart';
import './models/pyramid.dart';
import './models/sphere.dart';
import './models/triangle.dart';

void main() {
  print('Select a geometric shape or solid:');
  print('1 - Rectangle');
  print('2 - Circle');
  print('3 - Triangle');
  print('4 - Cube');
  print('5 - Sphere');
  print('6 - Cylinder');
  print('7 - Cone');
  print('8 - Pyramid');

  int choice = _getUserInputAsInt('Enter your choice:');

  switch (choice) {
    case 1:
      double width = _getUserInputAsDouble('Enter the width of the rectangle:');
      double height = _getUserInputAsDouble('Enter the height of the rectangle:');
      Rectangle rectangle = Rectangle(width, height);
      _printResults(
        area: rectangle.calculateArea(),
        perimeter: rectangle.calculatePerimeter(),
      );
      break;
    case 2:
      double radius = _getUserInputAsDouble('Enter the radius of the circle:');
      Circle circle = Circle(radius);
      _printResults(
        area: circle.calculateArea(),
        perimeter: circle.calculatePerimeter(),
      );
      break;
    case 3:
      double base = _getUserInputAsDouble('Enter the base of the triangle:');
      double height = _getUserInputAsDouble('Enter the height of the triangle:');
      Triangle triangle = Triangle(base, height);
      _printResults(
        area: triangle.calculateArea(),
        perimeter: triangle.calculatePerimeter(),
      );
      break;
    case 4:
      double side = _getUserInputAsDouble('Enter the side length of the cube:');
      Cube cube = Cube(side);
      _printResults(
        volume: cube.calculateVolume(),
        surfaceArea: cube.calculateSurfaceArea(),
      );
      break;
    case 5:
      double radius = _getUserInputAsDouble('Enter the radius of the sphere:');
      Sphere sphere = Sphere(radius);
      _printResults(
        volume: sphere.calculateVolume(),
        surfaceArea: sphere.calculateSurfaceArea(),
      );
      break;
    case 6: 
      double radius = _getUserInputAsDouble('Enter the radius of the cylinder:');
      double height = _getUserInputAsDouble('Enter the height of the cylinder:');
      Cylinder cylinder = Cylinder(radius, height);
      _printResults(
        volume: cylinder.calculateVolume(),
        surfaceArea: cylinder.calculateSurfaceArea(),
      );
      break;
    case 7:
      double radius = _getUserInputAsDouble('Enter the radius of the cone:');
      double height = _getUserInputAsDouble('Enter the height of the cone:');
      Cone cone = Cone(radius, height);
      _printResults(
        volume: cone.calculateVolume(),
        surfaceArea: cone.calculateSurfaceArea(),
      );
      break;
    case 8:
      double baseLength = _getUserInputAsDouble('Enter the base length of the pyramid:');
      double baseWidth = _getUserInputAsDouble('Enter the base width of the pyramid:');
      double height = _getUserInputAsDouble('Enter the height of the pyramid:');
      Pyramid pyramid = Pyramid(baseLength, baseWidth, height);
      _printResults(
        volume: pyramid.calculateVolume(),
        surfaceArea: pyramid.calculateSurfaceArea(),
      );
      break;
    default:
      print('Invalid option.');
  }
}

/// Function to get user input as an integer.
int _getUserInputAsInt(String prompt) {
  print(prompt);
  return int.parse(stdin.readLineSync()!);
}

/// Function to get user input as a double.
double _getUserInputAsDouble(String prompt) {
  print(prompt);
  return double.parse(stdin.readLineSync()!);
}

/// Function to print the results of the calculations.
void _printResults({double? area, double? perimeter, double? volume, double? surfaceArea}) {
  if (area != null) print('Area: ${area.toStringAsFixed(3)}');
  if (perimeter != null) print('Perimeter: ${perimeter.toStringAsFixed(3)}');
  if (volume != null) print('Volume: ${volume.toStringAsFixed(3)}');
  if (surfaceArea != null) print('Surface Area: ${surfaceArea.toStringAsFixed(3)}');
}
