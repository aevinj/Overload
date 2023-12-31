import 'dart:ui';
import 'package:flutter/material.dart';

class BlurryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double width; // Add a width property
  final double height; // Add a height property
  final Color? color;

  const BlurryButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.width = 150.0, // Default width
    this.height = 50.0, // Default height
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Adjust the blur intensity
        child: Container(
          width: width, // Set the width
          height: height, // Set the height
          decoration: BoxDecoration(
            color: color ?? Colors.grey[700]!.withOpacity(0.3), // Transparent background color
            borderRadius: BorderRadius.circular(16.0), // Optional: Add rounded corners
            border: Border.all(
              color: Colors.grey[800]!, // Border color
              width: 0.8, // Border width
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
