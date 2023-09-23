import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progressive_overload/box_manager.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/pages/new_workout.dart';
import 'package:progressive_overload/pages/workout.dart';
import 'package:progressive_overload/theme/dark_theme.dart';
import 'package:provider/provider.dart';

class ViewWorkoutsPage extends StatelessWidget {
  const ViewWorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final boxManager = Provider.of<BoxManager>(context);

    return Scaffold(
        backgroundColor: darkBackground(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("View Workouts"),
        ),
        body: Center(
          child: BlurryButton(
            width: 350,
            height: 600,
            onPressed: () {},
            child: boxManager.getWorkoutsAsList().isEmpty
                ? Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        const Icon(
                          CupertinoIcons.clear_circled,
                          color: Colors.white,
                          size: 100,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "No workouts found",
                          style: Font(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        BlurryButton(
                            width: 300,
                            height: 65,
                            onPressed: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => const NewWorkout()),
                              );
                            },
                            child: Text(
                              "Add more",
                              style: Font(size: 20),
                            ))
                      ]))
                : ListView.builder(
                    itemCount: boxManager.getWorkoutsAsList().length + 1,
                    itemBuilder: (context, index) {
                      if (index < boxManager.getWorkoutsAsList().length) {
                        var workout = boxManager.getWorkoutsAsList()[index];
                        return Column(
                          children: [
                            Dismissible(
                              direction: DismissDirection.endToStart,
                              key: UniqueKey(),
                              confirmDismiss: (direction) async {
                                final confirmed = await showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      icon: const Icon(
                                        CupertinoIcons.trash,
                                        color: Colors.white,
                                      ),
                                      backgroundColor: Colors.grey[900],
                                      title: Text(
                                        "Delete ${workout.name}?",
                                        style: Font(),
                                      ),
                                      content: Text(
                                        "Are you sure you want to delete ${workout.name} permanently?",
                                        style: Font(size: 16),
                                      ),
                                      actions: [
                                        BlurryButton(
                                          width: 100,
                                          height: 50,
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: Font(size: 16),
                                          ),
                                        ),
                                        BlurryButton(
                                          color: Colors.red,
                                          width: 100,
                                          height: 50,
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                          child: Text(
                                            "Delete",
                                            style: Font(size: 16),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                return confirmed ?? false;
                              },
                              onDismissed: (direction) async {
                                HapticFeedback.mediumImpact();
                                boxManager.deleteAtIndex(index);
                                if (boxManager.getWorkoutsAsList().isEmpty) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                }
                              },
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20.0),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 36.0,
                                ),
                              ),
                              child: Column(
                                children: [
                                  index == 0 ? const SizedBox.shrink() :
                                  const Divider(
                                    color: Colors.white,
                                  ),
                                  ListTile(
                                    title: workout.days.isEmpty
                                        ? Text(
                                            "Empty workout: ${workout.name}",
                                            style: Font(size: 20),
                                          )
                                        : Text(
                                            "${workout.name} - ${workout.split} - ${workout.days.length} day(s)",
                                            style: Font(size: 20),
                                          ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => WorkoutViewer(
                                            workout: workout,
                                            index: index,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return boxManager.dirtyBox()
                            ? Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  BlurryButton(
                                      width: 300,
                                      height: 65,
                                      onPressed: () {
                                        boxManager.cleanBox();
                                      },
                                      child: Text(
                                        "Remove empty workouts",
                                        style: Font(size: 20),
                                      )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  BlurryButton(
                                      width: 300,
                                      height: 65,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  const NewWorkout()),
                                        );
                                      },
                                      child: Text(
                                        "Add more",
                                        style: Font(size: 20),
                                      )),
                                ],
                              )
                            : Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  BlurryButton(
                                      width: 300,
                                      height: 65,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (context) =>
                                                  const NewWorkout()),
                                        );
                                      },
                                      child: Text(
                                        "Add more",
                                        style: Font(size: 20),
                                      )),
                                ],
                              );
                      }
                    },
                  ),
          ),
        ));
  }
}
