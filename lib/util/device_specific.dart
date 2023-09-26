import 'package:flutter/cupertino.dart';

double widthOfCurrentDevice(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double heightOfCurrentDevice(BuildContext context) {
  return MediaQuery.of(context).size.height;
}