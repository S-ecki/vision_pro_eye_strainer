import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vision_pro_eye_strainer/main.dart';

Offset randomOffsetInsideBox() {
  final windowSize = initialWindowsSize ?? const Size(600, 600);
  final max = Size(windowSize.width - 20, windowSize.height - 20);

  return Offset(
    Random().nextInt(max.width.toInt()).toDouble(),
    Random().nextInt(max.height.toInt()).toDouble(),
  );
}
