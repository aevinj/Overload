import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progressive_overload/components/side_menu_tile.dart';
import 'package:progressive_overload/components/side_menu_title.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/pages/new_workout.dart';
import 'package:progressive_overload/util/rive_asset.dart';
import 'package:progressive_overload/util/rive_utils.dart';
import 'package:rive/rive.dart';

class SideMenu extends StatefulWidget {
  final VoidCallback closeMenu;
  final SMIBool isMenuClosed;
  const SideMenu(
      {super.key, required this.closeMenu, required this.isMenuClosed});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedScreen = side_menu.first;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: 288,
          height: double.infinity,
          color: Colors.black,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SideMenuTitle(
              name: "Aevin",
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 30, 0, 20),
              child: Text(
                "BROWSE",
                style: Font(size: 18, color: Colors.grey),
              ),
            ),
            ...side_menu.map((e) => SideMenuTile(
                  menu: e,
                  riveOnInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,
                            stateMachineName: e.stateMachine);
                    e.input = controller.findSMI("active") as SMIBool;
                  },
                  press: () {
                    e.input!.change(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      e.input!.change(false);
                    });
                    setState(() {
                      selectedScreen = e;
                    });

                    Future.delayed(const Duration(milliseconds: 200), () {
                      widget.closeMenu();
                    });

                    Future.delayed(const Duration(milliseconds: 200), () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const NewWorkout()));
                    });

                    //TODO close side_menu and change screen
                  },
                  isActive: selectedScreen == e,
                ))
          ]),
        ),
      ),
    );
  }
}
