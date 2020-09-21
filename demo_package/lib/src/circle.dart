import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import './shape.dart';

class Circle extends Shape {
  Circle({@required this.radius}) : assert(radius != null);

  final double radius;

  @override
  double calculateArea() => math.pi * radius * radius;
}
