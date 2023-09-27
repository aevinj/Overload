import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback press;
  final ValueChanged<Artboard> riveonInit;

  const MenuButton({
    super.key, required this.press, required this.riveonInit,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          margin: const EdgeInsets.only(left: 16, top: 10),
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 3), blurRadius: 8)
              ]),
          child: RiveAnimation.asset(
            "assets/menu.riv",
            onInit: riveonInit,
          ),
        ),
      ),
    );
  }
}