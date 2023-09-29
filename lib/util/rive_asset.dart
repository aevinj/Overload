import 'package:rive/rive.dart';

class RiveAsset {
  final String artboard;
  final String stateMachine;
  final String title;
  final String srcPath;
  late SMIBool? input;

  RiveAsset(
      {required this.artboard,
      required this.stateMachine,
      required this.title,
      required this.srcPath,
      this.input});

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> side_menu = [
  RiveAsset(
      artboard: "HOME",
      stateMachine: "HOME_interactivity",
      title: "Home",
      srcPath: "assets/icon.riv"),
  RiveAsset(
      artboard: "RULES",
      stateMachine: "State Machine 1",
      title: "View Workouts",
      srcPath: "assets/icon.riv"),
  RiveAsset(
      artboard: "USER",
      stateMachine: "USER_Interactivity",
      title: "My account",
      srcPath: "assets/icon.riv"),
  RiveAsset(
      artboard: "TIMER",
      stateMachine: "TIMER_Interactivity",
      title: "Break Timer",
      srcPath: "assets/icon.riv"),
  RiveAsset(
      artboard: "SETTINGS",
      stateMachine: "SETTINGS_Interactivity",
      title: "Settings",
      srcPath: "assets/icon.riv"),
];
