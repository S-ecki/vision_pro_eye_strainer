import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vision_pro_eye_strainer/controller.dart';
import 'package:vision_pro_eye_strainer/view.dart';

Size? initialWindowsSize;

void main() {
  runApp(
    const ProviderScope(
      child: VisionApp(),
    ),
  );
  ChickenSoundLong().play();
}

class VisionApp extends ConsumerWidget {
  const VisionApp({super.key});

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
