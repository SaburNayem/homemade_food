import 'package:flutter/widgets.dart';

class Responsive {
  static bool isCompact(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 360;

  static bool isPhone(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 600;

  static double pagePadding(BuildContext context) =>
      isCompact(context) ? 16 : 20;

  static double blockSpacing(BuildContext context) =>
      isCompact(context) ? 14 : 20;
}
