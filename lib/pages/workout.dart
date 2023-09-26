import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progressive_overload/util/box_manager.dart';
import 'package:progressive_overload/classes/day.dart';
import 'package:progressive_overload/classes/exercise.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/edit_reps_sets_modal.dart';
import 'package:progressive_overload/components/capitalise.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/pages/add_exercise.dart';
import 'package:progressive_overload/theme/dark_theme.dart';
import 'package:progressive_overload/util/device_specific.dart';
import 'package:provider/provider.dart';

class WorkoutViewer extends StatefulWidget {
  final int index;

  const WorkoutViewer({super.key, required this.index});

  @override
  State<WorkoutViewer> createState() => _WorkoutViewerState();
}

class _WorkoutViewerState extends State<WorkoutViewer> {
  String _selectedDay = "Monday";

  void removeExercise(BoxManager boxManager, Exercise exercise) {
    setState(() {
      boxManager.deleteExercise(exercise, widget.index, _selectedDay);
      if (boxManager
          .getWorkoutsAsList()[widget.index]
          .days
          .firstWhere((day) => day.dayID == _selectedDay)
          .exercises
          .isEmpty) {
        boxManager.deleteDay(widget.index, _selectedDay);
      }
    });
  }

  void handleOptionChange(String? value) {
    if (value is String) {
      setState(() {
        _selectedDay = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final boxManager = Provider.of<BoxManager>(context);

    return Scaffold(
      backgroundColor: darkBackground(),
      appBar: AppBar(
        leadingWidth: 20,
        iconTheme: const IconThemeData(size: 30, color: Colors.white),
        title: Row(children: [
          const Spacer(),
          Text(
            boxManager.getWorkoutsAsList()[widget.index].name.capitalise(),
            style: Font(size: 30),
          ),
          const Spacer(),
          const SizedBox(
            width: 20,
          )
        ]),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text(
                'Day :',
                style: Font(),
              ),
              const SizedBox(
                width: 30,
              ),
              SizedBox(
                width: 200,
                child: DropdownButton(
                  dropdownColor: Colors.grey[900],
                  focusColor: Colors.purple[900],
                  iconEnabledColor: Colors.deepPurple,
                  iconSize: 42.0,
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(
                        value: "Monday",
                        child: Text(
                          "Monday",
                          style: boxManager.isDayEmpty(widget.index, "Monday")
                              ? Font(size: 20, color: Colors.grey[700]!)
                              : Font(size: 20),
                        )),
                    DropdownMenuItem(
                        value: "Tuesday",
                        child: Text(
                          "Tuesday",
                          style: boxManager.isDayEmpty(widget.index, "Tuesday")
                              ? Font(size: 20, color: Colors.grey[700]!)
                              : Font(size: 20),
                        )),
                    DropdownMenuItem(
                        value: "Wednesday",
                        child: Text(
                          "Wednesday",
                          style:
                              boxManager.isDayEmpty(widget.index, "Wednesday")
                                  ? Font(size: 20, color: Colors.grey[700]!)
                                  : Font(size: 20),
                        )),
                    DropdownMenuItem(
                        value: "Thursday",
                        child: Text(
                          "Thursday",
                          style: boxManager.isDayEmpty(widget.index, "Thursday")
                              ? Font(size: 20, color: Colors.grey[700]!)
                              : Font(size: 20),
                        )),
                    DropdownMenuItem(
                        value: "Friday",
                        child: Text(
                          "Friday",
                          style: boxManager.isDayEmpty(widget.index, "Friday")
                              ? Font(size: 20, color: Colors.grey[700]!)
                              : Font(size: 20),
                        )),
                    DropdownMenuItem(
                        value: "Saturday",
                        child: Text(
                          "Saturday",
                          style: boxManager.isDayEmpty(widget.index, "Saturday")
                              ? Font(size: 20, color: Colors.grey[700]!)
                              : Font(size: 20),
                        )),
                    DropdownMenuItem(
                        value: "Sunday",
                        child: Text(
                          "Sunday",
                          style: boxManager.isDayEmpty(widget.index, "Sunday")
                              ? Font(size: 20, color: Colors.grey[700]!)
                              : Font(size: 20),
                        )),
                  ],
                  value: _selectedDay,
                  onChanged: (value) => handleOptionChange(value),
                ),
              ),
            ]),
            const Spacer(),
            BlurryButton(
              width: widthOfCurrentDevice(context) * 0.65,
              height: heightOfCurrentDevice(context) * 0.65,
              onPressed: () {},
              child: !boxManager
                      .getWorkoutsAsList()[widget.index]
                      .days
                      .any((day) => day.dayID == _selectedDay)
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
                            "No Exercises found",
                            style: Font(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          BlurryButton(
                              width: 300,
                              height: 65,
                              onPressed: () async {
                                final Exercise? newExercise =
                                    await Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const AddExercise()),
                                );

                                if (newExercise != null) {
                                  boxManager.addExerciseToWorkout(
                                      widget.index, _selectedDay, newExercise);
                                }
                              },
                              child: Text(
                                "Add more",
                                style: Font(size: 20),
                              ))
                        ]))
                  : ListView.builder(
                      itemCount: boxManager
                          .getWorkoutsAsList()[widget.index]
                          .days
                          .length,
                      itemBuilder: (BuildContext context, int index) {
                        Day day = boxManager
                            .getWorkoutsAsList()[widget.index]
                            .days[index];

                        if (day.dayID == _selectedDay) {
                          return Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    day.exercises.map((Exercise exercise) {
                                  final isFirstExercise =
                                      day.exercises.indexOf(exercise) == 0;
                                  return Dismissible(
                                    direction: DismissDirection.endToStart,
                                    key: Key(exercise
                                        .name), // Use a unique key for each exercise
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
                                              "Delete ${exercise.name}?",
                                              style: Font(),
                                            ),
                                            content: Text(
                                              "Are you sure you want to delete ${exercise.name} from ${boxManager.getWorkoutsAsList()[widget.index].name}?",
                                              style: Font(size: 16),
                                            ),
                                            actions: [
                                              BlurryButton(
                                                width: 100,
                                                height: 50,
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
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
                                                  Navigator.of(context)
                                                      .pop(true);
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
                                    onDismissed: (direction) {
                                      HapticFeedback.mediumImpact();
                                      removeExercise(boxManager, exercise);
                                    },
                                    background: Container(
                                      color: Colors.red,
                                      alignment: Alignment.centerRight,
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 36.0,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        isFirstExercise
                                            ? const SizedBox.shrink()
                                            : const Column(
                                                children: [
                                                  Divider(
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  )
                                                ],
                                              ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                exercise.name,
                                                style: Font(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                int setCount = boxManager
                                                    .getWorkoutsAsList()[
                                                        widget.index]
                                                    .days
                                                    .firstWhere((day) =>
                                                        day.dayID ==
                                                        _selectedDay)
                                                    .exercises
                                                    .firstWhere((ex) =>
                                                        ex.name ==
                                                        exercise.name)
                                                    .sets!;

                                                int repCount = boxManager
                                                    .getWorkoutsAsList()[
                                                        widget.index]
                                                    .days
                                                    .firstWhere((day) =>
                                                        day.dayID ==
                                                        _selectedDay)
                                                    .exercises
                                                    .firstWhere((ex) =>
                                                        ex.name ==
                                                        exercise.name)
                                                    .reps!;

                                                showModalBottomSheet(
                                                  enableDrag: false,
                                                  backgroundColor:
                                                      Colors.grey[900],
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return ModalSheetContent(
                                                      initialSetCount: setCount,
                                                      onSetCountChanged:
                                                          (newSetCount) {
                                                        setState(() {
                                                          boxManager.modifySet(
                                                              widget.index,
                                                              _selectedDay,
                                                              exercise.name,
                                                              newSetCount);
                                                        });
                                                      },
                                                      initialRepsCount:
                                                          repCount,
                                                      onRepsCountChanged:
                                                          (newRepCount) {
                                                        setState(() {
                                                          boxManager.modifyRep(
                                                              widget.index,
                                                              _selectedDay,
                                                              exercise.name,
                                                              newRepCount);
                                                        });
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                              child: Text(
                                                //TODO: instead of "" replace with duration
                                                exercise.reps == null ||
                                                        exercise.sets == null
                                                    ? ""
                                                    : "${exercise.reps}x${boxManager.getWorkoutsAsList()[widget.index].days.firstWhere((day) => day.dayID == _selectedDay).exercises.firstWhere((ex) => ex.name == exercise.name).sets}",
                                                style: Font(
                                                    size: 16,
                                                    color: Colors.grey[600]!),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              BlurryButton(
                                  width: 300,
                                  height: 65,
                                  onPressed: () async {
                                    //TODO: unhandled for repeating names
                                    final Exercise? newExercise =
                                        await Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const AddExercise()),
                                    );

                                    if (newExercise != null) {
                                      boxManager.addExerciseToWorkout(
                                          widget.index,
                                          _selectedDay,
                                          newExercise);
                                    }
                                  },
                                  child: Text(
                                    "Add more",
                                    style: Font(size: 20),
                                  )),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
