import 'dart:math';

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'target_model.freezed.dart';

var _nextId = 0;

@freezed
class Target with _$Target {
  factory Target(Offset offset) => Target._internal(
        offset: offset,
        id: _nextId++,
        diameter: Random().nextInt(40) + 25,
      );
  const Target._();

  const factory Target._internal({
    required Offset offset,
    required int id,
    required double diameter,
  }) = _Target;

  double get left => offset.dx;
  double get top => offset.dy;
}
