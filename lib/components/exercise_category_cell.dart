import 'package:flutter/material.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/text_style.dart';

class ExerciseCategoryCell extends StatelessWidget {
  final String imgPath;
  final String categoryName;
  final VoidCallback onPressed;

  const ExerciseCategoryCell(
      {super.key, required this.categoryName, required this.imgPath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlurryButton(
        height: 200,
        width: 200,
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image(
                image: AssetImage(imgPath),
                width: 150,
                height: 125,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              categoryName,
              style: Font(),
            )
          ],
        ));
  }
}
