import 'package:flutter/material.dart';
import 'package:stopwatch_timer/page/countdown_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)
            .copyWith(background: const Color.fromARGB(255, 14, 13, 13)),
      ),
      home: const CountdownPage(),
    );
  }
}
