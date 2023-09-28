import 'package:flutter/material.dart';

TextStyle Font({ double size = 25.0, Color color = Colors.white, bool bold = false}) {
  return TextStyle(fontSize: size, color: color, fontWeight: bold ? FontWeight.bold : FontWeight.normal, fontFamily: 'SFPro');
}