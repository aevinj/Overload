
import 'package:flutter/material.dart';
import 'package:progressive_overload/components/text_style.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Center(child: Text("Settings screen- in development", style: Font(color: Colors.black, size: 22),)),
    );
  }
}