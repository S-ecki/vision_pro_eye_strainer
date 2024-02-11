import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vision_pro_eye_strainer/controller.dart';

class ClickerField extends ConsumerWidget {
  const ClickerField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targets = ref.watch(targetControllerProvider);

    return Stack(
      children: [
        const Confetter(),
        ...targets.map(
          (t) => Positioned(
            left: t.left,
            top: t.top,
            child: TargetCircle(t.id, diameter: t.diameter),
          ),
        ),
      ],
    );
  }
}

class TargetCircle extends ConsumerWidget {
  const TargetCircle(
    this.id, {
    super.key,
    this.diameter = 30,
    this.color = Colors.deepPurple,
  });

  final int id;
  final double diameter;
  final Color color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipPath(
      child: Container(
        width: diameter,
        height: diameter,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: GestureDetector(
          onTap: () {
            ChickenSoundShort().play();
            ref.read(targetControllerProvider.notifier).kill(id);
          },
          child: Image.asset('assets/head.png'),
        ),
      ),
    );
  }
}

class ScoreText extends ConsumerWidget {
  const ScoreText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(scoreControllerProvider);
    final level = ref.watch(levelProvider);

    return Text(
      level == -1
          ? 'Congratulations! You are a Vision Bro! 🥽'
          : 'Score: $score     Level: $level',
    );
  }
}

class Confetter extends ConsumerStatefulWidget {
  const Confetter({super.key});

  @override
  ConsumerState<Confetter> createState() => _ConfetterState();
}

class _ConfetterState extends ConsumerState<Confetter> {
  late final ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        ConfettiController(duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(levelProvider, (prev, next) {
      if (prev != next) {
        _controller.play();
      }
    });
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _controller,
            shouldLoop: ref.watch(levelProvider) == -1,
            colors: const [
              Colors.yellow,
              Colors.orange,
              Colors.red,
            ],
            blastDirectionality: BlastDirectionality.explosive,
          ),
        ),
      ],
    );
  }
}
