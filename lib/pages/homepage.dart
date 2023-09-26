import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progressive_overload/util/box_manager.dart';
import 'package:progressive_overload/components/blurred_button.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/pages/new_workout.dart';
import 'package:progressive_overload/pages/view_workouts.dart';
import 'package:progressive_overload/theme/dark_theme.dart';
import 'package:progressive_overload/util/device_specific.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final boxManager = Provider.of<BoxManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          const Icon(
            CupertinoIcons.home,
            color: Colors.white,
            size: 30,
          ),
          const Spacer(),
          Text("Home", style: Font(size: 30)),
          const Spacer(),
          const SizedBox(width: 30,),
        ]),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: darkBackground(),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          BlurryButton(
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
      ),
    );
  }
}
