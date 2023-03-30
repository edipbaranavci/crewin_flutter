import 'package:flutter/material.dart';

class AppColors {
  static AppColors? _instance;
  // Avoid self isntance
  AppColors._();
  static AppColors get instance {
    _instance ??= AppColors._();
    return _instance!;
  }

  final Color primary = const Color(0xff362706);
  final Color secondary = const Color(0xff464E2E);
  final Color onSecondary = const Color(0xffACB992);
  final Color onPrimary = const Color(0xffE9E5D6);
  final Color whiteColor = Colors.white;
  final Color redColor = Colors.red;
  final Color greenColor = Colors.green;
}
