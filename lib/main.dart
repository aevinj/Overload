import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeAnimationCurve: Curves.ease,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Welcome")),
        ),
        body: const Center(
            child: Text(
          "Aevin",
          style: TextStyle(fontSize: 24),
        )),
      ),
    );
  }
}
