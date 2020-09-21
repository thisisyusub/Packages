import 'package:meta/meta.dart';
import './shape.dart';

class Rectangle extends Shape {
  Rectangle({@required this.width, @required this.height});

  final double width;
  final double height;

  @override
  double calculateArea() => width * height;
}
