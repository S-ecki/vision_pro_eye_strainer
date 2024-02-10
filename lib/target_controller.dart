import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vision_pro_eye_strainer/target_model.dart';

part 'target_controller.g.dart';

@riverpod
class TargetController extends _$TargetController {
  @override
  List<Target> build() {
    return [
      Target(const Offset(0, 0)),
      Target(const Offset(100, 100)),
      Target(const Offset(200, 200)),
      Target(const Offset(300, 300)),
      Target(const Offset(400, 400)),
      Target(const Offset(500, 500)),
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
