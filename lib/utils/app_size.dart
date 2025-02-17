import 'package:flutter/material.dart';

class AppWidgetSize {
  // Minumum screen width Ratio as per the UI/UX
  static const double bodyPadding = 18;
  static const double dimen_0 = 0;

  static const double dimen_1 = 1;
  static const double dimen_5 = 5;
  static const double dimen_8 = 8;
  static const double dimen_10 = 10;
  static const double dimen_12 = 12;
  static const double dimen_14 = 14;
  static const double dimen_15 = 15;
  static const double dimen_16 = 16;
  static const double dimen_18 = 18;
  static const double dimen_20 = 20;
  static const double dimen_24 = 24;
  static const double dimen_25 = 25;
  static const double dimen_30 = 30;
  static Size screenSize(BuildContext context) {
    return MediaQuery.sizeOf(context);
  }

  static EdgeInsets safeAreaPadding(BuildContext context) {
    return MediaQuery.viewPaddingOf(context);
  }

  static double screenWidth(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).width / dividedBy;
  }

  static double screenHeight(BuildContext context, {double dividedBy = 1}) {
    return (screenSize(context).height - safeAreaPadding(context).top) /
        dividedBy;
  }
}
