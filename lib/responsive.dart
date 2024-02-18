import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 576;

  // Treat both tablet and desktop as desktop
  static bool isTablet(BuildContext context) => false;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 576;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (isDesktop(context)) {
      return desktop;
    } else {
      return mobile;
    }
  }
}
