import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'target_model.freezed.dart';

var _nextId = 0;

@freezed
class Target with _$Target {
  factory Target(Offset offset) =>
      Target._internal(offset: offset, id: _nextId++);
  const Target._();

  const factory Target._internal({
    required Offset offset,
    required int id,
  }) = _Target;

  double get left => offset.dx;
  double get top => offset.dy;
}
