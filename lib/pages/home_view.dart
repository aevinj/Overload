import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/pages/new_workout.dart';
import 'package:progressive_overload/pages/view_workouts.dart';
import 'package:progressive_overload/util/box_manager.dart';
import 'package:progressive_overload/util/device_specific.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
    required this.boxManager,
  });

  final BoxManager boxManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      // body: oldMenu(boxManager: boxManager),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 72),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Home",
                  style: Font(color: Colors.black, size: 30, bold: true),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32.0, top: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Good morning Aevin",
                style: Font(color: Colors.grey[600]!, bold: true, size: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 36),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent workouts",
                style: Font(bold: true, color: Colors.black, size: 22),
              ),
            ),
          ),
          const SingleChildScrollView(
              clipBehavior: Clip.antiAlias,
              padding: EdgeInsets.only(bottom: 10, right: 16),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  RecentWorkoutCard(),
                  RecentWorkoutCard(),
                  RecentWorkoutCard(),
                ],
              )),
        ]),
      ),
    );
  }
}

class RecentWorkoutCard extends StatelessWidget {
  const RecentWorkoutCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: widthOfCurrentDevice(context) * 0.5, // Set the width
          height: widthOfCurrentDevice(context) * 0.5, // Set the height
          decoration: BoxDecoration(
              color: Colors.deepPurpleAccent, // Transparent background color
              borderRadius:
                  BorderRadius.circular(16.0), // Optional: Add rounded corners
              boxShadow: const [
                BoxShadow(
                    color: Colors.black,
                    offset: Offset(2, 2),
                    blurRadius: 5,
                    spreadRadius: 2)
              ]),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 10, right: 10, bottom: 20),
                child: Column(children: [
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.arrowtriangle_right_fill,
                        color: Colors.white,
                        size: 18,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: SizedBox(
                          width: 124,
                          child: Text(
                            "Start New Workout 1",
                            overflow: TextOverflow.fade,
                            style: Font(size: 18, bold: true),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "Et aute in veniam ea sit. Occaecat exercitation elit eiusmod irure.",
                      style: Font(
                          color: const Color.fromARGB(255, 167, 166, 166),
                          size: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.chart_bar_circle,
                          color: Colors.white,
                          size: 18,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Text(
                            "121 Kcal - 72 mins",
                            style: Font(
                                color: const Color.fromARGB(255, 167, 166, 166),
                                size: 15),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ),
        ),
      ),

      // BlurryButton(
      //     width: widthOfCurrentDevice(context) * 0.5,
      //     height: widthOfCurrentDevice(context) * 0.5,
      //     color: Colors.deepPurpleAccent,
      //     onPressed: () {},
      //     child: Column(children: [
      //       Text(
      //         "Start New Workout 1",
      //         style: Font(size: 18, bold: true),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(top: 10),
      //         child: Text("Et aute in veniam ea sit. Occaecat exercitation elit eiusmod irure.", style: Font(color: Color.fromARGB(255, 37, 37, 37), size: 14),),
      //       )
      //     ])),
    );
  }
}

class oldMenu extends StatelessWidget {
  const oldMenu({
    super.key,
    required this.boxManager,
  });

  final BoxManager boxManager;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        BlurryButton(
          color: Colors.deepPurpleAccent,
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => const ViewWorkoutsPage()),
            );
          },
          width: widthOfCurrentDevice(context) * 0.8,
          height: heightOfCurrentDevice(context) * 0.175,
          child: Text(
            "View Workouts",
            style: Font(),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        BlurryButton(
          color: Colors.deepPurpleAccent,
          onPressed: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => const NewWorkout()));
          },
          width: widthOfCurrentDevice(context) * 0.8,
          height: heightOfCurrentDevice(context) * 0.175,
          child: Text(
            "New workout",
            style: Font(),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        BlurryButton(
          color: Colors.deepPurpleAccent,
          onPressed: () async {
            await boxManager.clearBox();
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Deleted all workouts',
                  style: Font(size: 16),
                ),
                duration: const Duration(milliseconds: 1275),
                showCloseIcon: true,
                closeIconColor: Colors.red,
              ),
            );
          },
          width: widthOfCurrentDevice(context) * 0.8,
          height: heightOfCurrentDevice(context) * 0.175,
          child: Text(
            "Delete all workouts",
            style: Font(),
            textAlign: TextAlign.center,
          ),
        ),
      ]),
    );
  }
}
