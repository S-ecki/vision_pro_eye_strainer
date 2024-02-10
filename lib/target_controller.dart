import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vision_pro_eye_strainer/target_model.dart';
import 'package:vision_pro_eye_strainer/target_utils.dart';

part 'target_controller.g.dart';

@riverpod
class TargetController extends _$TargetController {
  late final Timer _timer;

  @override
  List<Target> build() {
    _timer = Timer.periodic(const Duration(seconds: 1), (i) => add());
    ref.onDispose(_timer.cancel);

    return [
      Target(const Offset(0, 0)),
      Target(const Offset(700, 70)),
      Target(const Offset(100, 620)),
    ];
  }

  void add() {
    final offset = randomOffsetInsideBox();
    state = [
      ...state,
      Target(offset),
    ];
  }

  void kill(int id) {
    state = state.where((t) => t.id != id).toList();
    ref.read(scoreControllerProvider.notifier).increment();
  }

  void startOrStop() {
    if (_timer.isActive) {
      _timer.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (i) => add());
    }
    _timer.cancel();
  }
}

@riverpod
class ScoreController extends _$ScoreController {
  @override
  int build() {
    return 0;
  }

  void increment() {
    state++;
  }
}

@riverpod
class Viewport extends _$Viewport {
  @override
  Size build() {
    return const Size(600, 600);
  }

  @override
  set state(Size offset) {
    state = offset;
  }
}
