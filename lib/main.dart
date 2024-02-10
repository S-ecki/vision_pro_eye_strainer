import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vision_pro_eye_strainer/audio_controller.dart';
import 'package:vision_pro_eye_strainer/target_controller.dart';
import 'package:vision_pro_eye_strainer/target_view.dart';

// TODO: 3 second countdown
// TODO: animation of targets
Size? initialWindowsSize;

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
  ChickenSoundLong().play();
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO refactor
    initialWindowsSize = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const ScoreText(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: const Text('Just 👀 and 👌🏼')
                  .animate()
                  .scale(duration: 3.seconds)
                  .shake(duration: 3.seconds, delay: 3.seconds, hz: 6),
            ),
            IconButton(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              onPressed: () {
                ref.read(targetControllerProvider.notifier).clear();
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: 0.4,
              image: AssetImage('assets/bg.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: const ClickerField(), //const ClickerField(),
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
