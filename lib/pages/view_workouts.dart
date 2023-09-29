import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progressive_overload/util/box_manager.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/pages/new_workout.dart';
import 'package:progressive_overload/pages/workout.dart';
import 'package:progressive_overload/util/device_specific.dart';
import 'package:provider/provider.dart';

class ViewWorkoutsPage extends StatelessWidget {
  const ViewWorkoutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final boxManager = Provider.of<BoxManager>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        SizedBox(
          height: heightOfCurrentDevice(context) * 0.15,
          child: Padding(
            padding: const EdgeInsets.only(right: 16, top: 42),
            child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "View Workouts",
                  style: Font(color: Colors.black, size: 30, bold: true),
                )),
          ),
        ),
        boxManager.getWorkoutsAsList().isEmpty
            ? SizedBox(
                height: heightOfCurrentDevice(context) * 0.85,
                child: Container(
                  constraints: const BoxConstraints.expand(),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          CupertinoIcons.clear_circled,
                          color: Colors.black,
                          size: 100,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "No workouts found",
                          style: Font(color: Colors.black),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: 200,
                          height: 65,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(colors: [
                                Colors.blue[700]!,
                                Colors.deepPurpleAccent[400]!,
                              ])),
                          child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const NewWorkout()),
                                    );
                                  },
                                  child: Center(
                                      child: Text(
                                    "Add More",
                                    style: Font(bold: true),
                                  )))),
                        ),
                      ]),
                ),
              )
            : SizedBox(
                height: heightOfCurrentDevice(context) * 0.7,
                child: Container(
                  constraints: const BoxConstraints.expand(),
                  child: ListView.builder(
                    itemCount: boxManager.getWorkoutsAsList().length + 1,
                    itemBuilder: (context, index) {
                      if (index < boxManager.getWorkoutsAsList().length) {
                        var workout = boxManager.getWorkoutsAsList()[index];
                        return Container(
                          color: Colors.grey[300],
                          child: Column(
                            children: [
                              Dismissible(
                                direction: DismissDirection.endToStart,
                                key: UniqueKey(),
                                confirmDismiss: (direction) async {
                                  final confirmed = await showDialog<bool>(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                        icon: const Icon(
                                          CupertinoIcons.trash,
                                          color: Colors.white,
                                        ),
                                        backgroundColor: Colors.grey[900],
                                        title: Text(
                                          "Delete ${workout.name}?",
                                          style: Font(color: Colors.white),
                                        ),
                                        content: Text(
                                          "Are you sure you want to delete ${workout.name} permanently?",
                                          style:
                                              Font(size: 16, color: Colors.white),
                                        ),
                                        actions: [
                                          BlurryButton(
                                            width: widthOfCurrentDevice(context) *
                                                0.3,
                                            height:
                                                heightOfCurrentDevice(context) *
                                                    0.1,
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: Font(
                                                  size: 16, color: Colors.white),
                                            ),
                                          ),
                                          BlurryButton(
                                            color: Colors.red,
                                            width: widthOfCurrentDevice(context) *
                                                0.3,
                                            height:
                                                heightOfCurrentDevice(context) *
                                                    0.1,
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                            child: Text(
                                              "Delete",
                                              style: Font(
                                                  size: 16, color: Colors.white),
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
                                    // Navigator.pop(context);
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
                                    index == 0
                                        ? const SizedBox.shrink()
                                        : const Padding(
                                            padding: EdgeInsets.only(
                                                left: 16, right: 16),
                                            child: Divider(
                                              thickness: 1,
                                              color: Colors.black,
                                            ),
                                          ),
                                    ListTile(
                                      selectedTileColor: Colors.blue,
                                      title: workout.days.isEmpty
                                          ? SizedBox(
                                            height: 100,
                                            child: Row(
                                                children: [
                                                  const Icon(
                                                    CupertinoIcons.bars,
                                                    color: Colors.black,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10),
                                                    child: SizedBox(
                                                      width: widthOfCurrentDevice(context) * 0.8,
                                                      child: Text(
                                                        "Empty workout: ${workout.name}",
                                                        style: Font(
                                                            size: 20,
                                                            color: Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          )
                                          : SizedBox(
                                            height: 100,
                                            child: Row(
                                                children: [
                                                  const Icon(
                                                    CupertinoIcons.bars,
                                                    color: Colors.black,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10),
                                                    child: SizedBox(
                                                      width: widthOfCurrentDevice(context) * 0.8,
                                                      child: Text(
                                                        "${workout.name} - ${workout.split} - ${workout.days.length} day(s)",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: Font(
                                                            size: 20,
                                                            color: Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => WorkoutViewer(
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
                          ),
                        );
                      } else {
                        return boxManager.dirtyBox()
                            ? Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 300,
                                    height: 65,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        gradient: LinearGradient(colors: [
                                          Colors.blue[700]!,
                                          Colors.deepPurpleAccent[400]!,
                                        ])),
                                    child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                            onTap: () {
                                              boxManager.cleanBox();
                                            },
                                            child: Center(
                                                child: Text(
                                              "Remove empty workouts",
                                              style: Font(size: 20, bold: true),
                                            )))),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ),
        if (boxManager.getWorkoutsAsList().isNotEmpty)
          SizedBox(
            height: heightOfCurrentDevice(context) * 0.15,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 200,
                height: 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(colors: [
                      Colors.blue[700]!,
                      Colors.deepPurpleAccent[400]!,
                    ])),
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const NewWorkout()),
                          );
                        },
                        child: Center(
                            child: Text(
                          "Add More",
                          style: Font(bold: true),
                        )))),
              ),
            ),
          )
      ]),
    );
  }
}