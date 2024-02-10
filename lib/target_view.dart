import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vision_pro_eye_strainer/target_controller.dart';

class ClickerField extends ConsumerWidget {
  const ClickerField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targets = ref.watch(targetControllerProvider);

    return Stack(
      children: [
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
    return ClipOval(
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: GestureDetector(
          onTap: () {
            print('Container clicked with id $id');
            ref.read(targetControllerProvider.notifier).kill(id);
          },
        ),
      ),
    );
  }
}
