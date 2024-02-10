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

  static const _initialDuration = Duration(seconds: 1, milliseconds: 800);

  @override
  List<Target> build() {
    _timer = Timer.periodic(
      _initialDuration,
      (i) async {
        await Future.delayed(const Duration(milliseconds: 5000));
        add();
      },
    );
    ref.listen(levelProvider, (previous, next) async {
      state = [];
      final delay = switch (next) {
        1 => _initialDuration,
        2 => const Duration(seconds: 1, milliseconds: 100),
        3 => const Duration(milliseconds: 800),
        4 => const Duration(milliseconds: 600),
        5 => const Duration(milliseconds: 400),
        _ => const Duration(milliseconds: 250),
      };
      _timer.cancel();
      if (next != -1) {
        await Future.delayed(const Duration(milliseconds: 1500));
        _timer = Timer.periodic(delay, (i) => add());
      }
    });
    ref.onDispose(_timer.cancel);

    return [];
  }

  void add() {
    final size = ref.read(sizeProvider);
    final offset = ref.read(randomOffsetProvider);

    state = [
      ...state,
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
    < 69 => 5,
    < 80 => 9000,
    _ => -1,
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
    5 => 45.0,
    9000 => 30.0,
    _ => 0
  };
}
