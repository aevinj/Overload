import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/pages/homepage.dart';
import 'package:progressive_overload/theme/dark_theme.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackground(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            "Overload",
            style: Font(),
          ),
        ),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Image(
            image: AssetImage("assets/logo.png"),
          ),
          const SizedBox(height: 50,),
          Text(
            "Welcome to Overload!",
            style: Font(size: 35),
          ),
          Text(
            "Your personal gym tracker for progressive overloading",
            style: Font(size: 12),
          ),
          const SizedBox(
            height: 50,
          ),
          BlurryButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => const Homepage()));
            },
            width: 200.0,
            height: 60.0,
            child: const Text(
              "Let's go",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
