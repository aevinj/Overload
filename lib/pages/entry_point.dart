import 'dart:math';
import 'package:flutter/material.dart';
import 'package:progressive_overload/components/menu_button.dart';
import 'package:progressive_overload/components/side_menu.dart';
import 'package:progressive_overload/pages/home_view.dart';
import 'package:progressive_overload/util/box_manager.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/util/device_specific.dart';
import 'package:progressive_overload/util/rive_utils.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late SMIBool isMenuClosed;
  bool isSideMenuClosed = true;
  late AnimationController _animationController;
  late Animation animation;
  late Animation scaleAnimation;
  bool showSettingsPage = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));

    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boxManager = Provider.of<BoxManager>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              width: 288,
              left: isSideMenuClosed ? -288 : 0,
              height: heightOfCurrentDevice(context),
              child: SideMenu(
                closeMenu: (e) {
                  if (!isSideMenuClosed) {
                    _animationController.reverse();
                    setState(() {
                      isSideMenuClosed = true;
                      isMenuClosed.value = true;
                      if (e.title == "Settings") {
                        showSettingsPage = true;
                      } else {
                        showSettingsPage = false;
                      }
                    });
                  }
                },
              )),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value - 30 * animation.value * pi / 180),
            child: Transform.translate(
              offset: Offset(animation.value * 265, 0),
              child: Transform.scale(
                scale: scaleAnimation.value,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  child: showSettingsPage ? Center(child: Text("Settings page", style: Font(),)) : HomeView(boxManager: boxManager),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideMenuClosed ? 0 : 220,
            child: MenuButton(
              riveonInit: (artboard) {
                StateMachineController controller = RiveUtils.getRiveController(
                    artboard,
                    stateMachineName: "State Machine");
                isMenuClosed = controller.findSMI("isOpen") as SMIBool;
                isMenuClosed.value = true;
              },
              press: () {
                isMenuClosed.value = !isMenuClosed.value;

                if (isSideMenuClosed) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }

                setState(() {
                  isSideMenuClosed = isMenuClosed.value;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
