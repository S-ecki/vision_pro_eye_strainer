import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vision_pro_eye_strainer/main.dart';
import 'package:vision_pro_eye_strainer/target_model.dart';

part 'target_controller.g.dart';

@riverpod
class TargetController extends _$TargetController {
  late Timer _timer;

  @override
  List<Target> build() {
    _timer = Timer.periodic(
      const Duration(seconds: 1, milliseconds: 200),
      (i) => add(),
    );
    ref.listen(levelProvider, (previous, next) {
      final delay = switch (next) {
        1 => const Duration(seconds: 1, milliseconds: 200),
        2 => const Duration(milliseconds: 850),
        3 => const Duration(milliseconds: 700),
        4 => const Duration(milliseconds: 500),
        5 => const Duration(milliseconds: 300),
        _ => const Duration(milliseconds: 150),
      };
      _timer.cancel();
      _timer = Timer.periodic(delay, (i) => add());
    });
    ref.onDispose(_timer.cancel);

    return [];
  }

  void add() {
    final size = ref.read(sizeProvider);
    final offset = ref.read(randomOffsetProvider);
    final newestTen = state.reversed.take(10).toList();
    state = [
      ...newestTen,
      Target(offset, diameter: size),
    ];
  }

  void kill(int id) {
    state = state.where((t) => t.id != id).toList();
    ref.read(scoreControllerProvider.notifier).increment();
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
Offset randomOffset(RandomOffsetRef ref) {
  final windowSize = initialWindowsSize ?? const Size(600, 600);
  final max = Size(windowSize.width - 170, windowSize.height - 170);

  return Offset(
    Random().nextInt(max.width.toInt()).toDouble(),
    Random().nextInt(max.height.toInt()).toDouble(),
  );
}

@riverpod
int level(LevelRef ref) {
  final score = ref.watch(scoreControllerProvider);
  return switch (score) {
    < 5 => 1,
    < 12 => 2,
    < 25 => 3,
    < 50 => 4,
    < 70 => 5,
    _ => 9000
  };
}

@riverpod
double size(SizeRef ref) {
  final level = ref.read(levelProvider);
  return switch (level) {
    1 => 100.0,
    2 => 85.0,
    3 => 70.0,
    4 => 55.0,
    5 => 40.0,
    _ => 25.0
  };
}
