import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vision_pro_eye_strainer/target_controller.dart';
import 'package:vision_pro_eye_strainer/target_view.dart';

Size? initialWindowsSize;

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
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
          title: const ScoreText(),
          actions: [
            IconButton(
              onPressed: () {
                ref.read(targetControllerProvider.notifier).add();
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: const ClickerField(),
      ),
    );
  }
}

class ScoreText extends ConsumerWidget {
  const ScoreText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(scoreControllerProvider);
    return Text('Score: $score');
  }
}
