import 'package:flutter/material.dart';

class CupertinoStyleCard extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  

  const CupertinoStyleCard({
    super.key, required this.width, required this.height, required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.blue[700]!,
            Colors.deepPurpleAccent[400]!,
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          borderRadius:
              BorderRadius.circular(16.0), // Optional: Add rounded corners
          // boxShadow: const [
          //   BoxShadow(
          //       color: Colors.black,
          //       offset: Offset(2, 2),
          //       blurRadius: 5,
          //       spreadRadius: 2)
          // ]
          ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(
                top: 20, left: 10, right: 10, bottom: 20),
            child: child,
          ),
        ),
      ),
    );
  }
}