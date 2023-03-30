import 'package:crewin_flutter/core/init/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static CustomTheme? _instance;
  CustomTheme._();
  static CustomTheme get instance {
    _instance ??= CustomTheme._();
    return _instance!;
  }

  final _colors = AppColors.instance;

  ThemeData getThemeData(BuildContext context) {
    return context.theme.copyWith(
      useMaterial3: true,
      primaryColor: const Color(0xff362706),
      colorScheme: context.theme.colorScheme.copyWith(
        primary: _colors.primary,
        secondary: _colors.secondary,
        onSecondary: _colors.onSecondary,
        onPrimary: _colors.onPrimary,
        onBackground: _colors.whiteColor,
        error: _colors.redColor,
      ),
    );
  }
}

extension _ on BuildContext {
  ThemeData get theme => Theme.of(this);
}
