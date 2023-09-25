import 'package:flutter/material.dart';
import 'package:progressive_overload/classes/prebuilt_exercises.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:provider/provider.dart';
import 'package:progressive_overload/theme/dark_theme.dart';

class PrebuiltExercisesViewer extends StatefulWidget {
  final List<String> category;
  final String? title;
  const PrebuiltExercisesViewer({super.key, required this.category, this.title});

  @override
  State<PrebuiltExercisesViewer> createState() =>
      _PrebuiltExercisesViewerState();
}

class _PrebuiltExercisesViewerState extends State<PrebuiltExercisesViewer> {
  @override
  Widget build(BuildContext context) {
    final exercisesManager = Provider.of<PrebuiltExercises>(context);
    final categoryExercises = widget.category
        .expand((c) => exercisesManager.getExercisesByCategory(c))
        .toList();

    return Scaffold(
      backgroundColor: darkBackground(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: widget.title == null ? Text(
          "${widget.category[0]} Exercises",
          style: Font(),
        ) : Text("${widget.title!} Exercises", style: Font(),)
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: ListView.builder(
          itemCount: categoryExercises.length,
          itemBuilder: (context, index) {
            final exercise = categoryExercises[index];
            return Column(
              children: [
                index == 0
                    ? const SizedBox.shrink()
                    : const Divider(
                        color: Colors.white,
                      ),
                ListTile(
                  title: Text(
                    exercise.name,
                    style: Font(size: 20),
                  ),
                  subtitle: Text(
                    "Sets: ${exercise.sets}, Reps: ${exercise.reps}",
                    style: Font(size: 16),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
