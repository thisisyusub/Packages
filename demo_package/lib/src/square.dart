import 'package:meta/meta.dart';
import './shape.dart';

class Square extends Shape {
  Square({@required this.a});

  final double a;

  @override
  double calculateArea() => a * a;
}
