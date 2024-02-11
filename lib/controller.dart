// ignore_for_file: inference_failure_on_instance_creation

import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vision_pro_eye_strainer/main.dart';
import 'package:vision_pro_eye_strainer/model.dart';

part 'controller.g.dart';

@riverpod
class TargetController extends _$TargetController {
  late Timer _timer;

  static const _initialDuration = Duration(seconds: 1, milliseconds: 800);

  @override
  List<Target> build() {
    _timer = Timer.periodic(
      _initialDuration,
      (_) async {
        await Future.delayed(5.seconds);
        add();
      },
    );
    ref
      ..listen(levelProvider, (previous, next) async {
        state = [];
        final delay = _delayFromLevel(next);
        _timer.cancel();
        if (next != -1) {
          await Future.delayed(const Duration(milliseconds: 1500));
          _timer = Timer.periodic(delay, (i) => add());
        }
      })
      ..onDispose(_timer.cancel);

    return [];
  }

  void add() {
    final size = ref.read(sizeProvider);

    state = [
      ...state,
      Target(_randomOffset, diameter: size),
    ];
  }

  void kill(int id) {
    state = state.where((t) => t.id != id).toList();
    ref.read(scoreControllerProvider.notifier).increment();
  }

  void clear() {
    state = [];
    ref.read(scoreControllerProvider.notifier).clear();
  }

  Duration _delayFromLevel(int level) {
    return switch (level) {
      1 => _initialDuration,
      2 => const Duration(seconds: 1, milliseconds: 100),
      3 => const Duration(milliseconds: 800),
      4 => const Duration(milliseconds: 600),
      5 => const Duration(milliseconds: 400),
      _ => const Duration(milliseconds: 250),
    };
  }

  Offset get _randomOffset {
    final windowSize = initialWindowsSize ?? const Size(600, 600);
    final max = Size(windowSize.width - 170, windowSize.height - 170);

    return Offset(
      Random().nextInt(max.width.toInt()).toDouble(),
      Random().nextInt(max.height.toInt()).toDouble(),
    );
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

  void clear() {
    state = 0;
  }
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

class ChickenSoundShort {
  ChickenSoundShort() : player = AudioPlayer() {
    player.setPlayerMode(PlayerMode.lowLatency);
  }
  final AudioPlayer player;

  void play() {
    player.play(AssetSource('sound-short.mp3'));
  }
}

class ChickenSoundLong {
  factory ChickenSoundLong() => _instance;
  ChickenSoundLong._() : player = AudioPlayer() {
    player.setReleaseMode(ReleaseMode.loop);
  }
  static final _instance = ChickenSoundLong._();

  final AudioPlayer player;

  void play() {
    player
      ..stop()
      ..play(AssetSource('sound-long.mp3'), volume: 0.05);
  }
}
