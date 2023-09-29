import 'package:flutter/material.dart';
import 'package:progressive_overload/components/side_menu_tile.dart';
import 'package:progressive_overload/components/side_menu_title.dart';
import 'package:progressive_overload/components/text_style.dart';
import 'package:progressive_overload/theme/dark_theme.dart';
import 'package:progressive_overload/util/rive_asset.dart';
import 'package:progressive_overload/util/rive_utils.dart';
import 'package:rive/rive.dart';

class SideMenu extends StatefulWidget {
  final Function(RiveAsset) closeMenu;
  const SideMenu(
      {super.key, required this.closeMenu});

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
          color: darkBackground(),
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
                    e.input = controller.findSMI("active") ?? controller.findSMI("isActive") as SMIBool;
                  },
                  press: () {
                    e.input!.change(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      e.input!.change(false);
                    });
                    setState(() {
                      selectedScreen = e;
                    });

                    Future.delayed(const Duration(milliseconds: 500), () {
                      widget.closeMenu(e);
                    });
                  },
                  isActive: selectedScreen == e,
                ))
          ]),
        ),
      ),
    );
  }
}
