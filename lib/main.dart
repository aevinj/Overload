import 'package:flutter/material.dart';
import 'package:progressive_overload/theme/dark_theme.dart';
import 'package:progressive_overload/theme/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeAnimationCurve: Curves.ease,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Overload")),
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
