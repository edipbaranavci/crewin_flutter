import 'package:crewin_flutter/core/init/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../components/button/custom_text_button.dart';

extension SnackBarExtension on GlobalKey<ScaffoldState> {
  RoundedRectangleBorder get roundedRectangleBorder => RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      );

  String get closeButtonTitle => 'Kapat';
  get context => currentContext;

  void showGreatSnackBar(
    String message, {
    Color? textColor,
    Color? backColor,
  }) {
    return _showSnackBar(
      message,
      true,
      backColor: backColor,
      textColor: textColor ?? Colors.white,
    );
  }

  void showErrorSnackBar(
    String message, {
    Color? textColor,
    Color? backColor,
  }) {
    return _showSnackBar(
      message,
      false,
      backColor: backColor,
      textColor: textColor ?? Colors.white,
    );
  }

  void showLoadingBar() {
    if (context != null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: roundedRectangleBorder,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          content: Center(
            child: CircularProgressIndicator(
              color: AppColors.instance.whiteColor,
            ),
          ),
        ),
      );
    }
  }

  void _showSnackBar(
    String message,
    bool isGreat, {
    Color? textColor,
    Color? backColor,
  }) {
    if (context != null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: roundedRectangleBorder,
          content: ListTile(
            shape: roundedRectangleBorder,
            leading: buildIcon(
              isGreat ? Icons.done : Icons.error_outline,
              textColor,
            ),
            title: buildMessage(currentState?.context, message, textColor),
            trailing: buildCloseButton(textColor),
            tileColor: backColor ??
                (isGreat
                    ? AppColors.instance.greenColor
                    : AppColors.instance.redColor),
          ),
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.zero,
        ),
      );
    }
  }

  Text buildMessage(BuildContext? context, String message, Color? textColor) {
    return Text(
      message,
      style: context?.textTheme.bodyMedium?.copyWith(
        color: textColor ?? currentState?.context.colorScheme.primary,
      ),
    );
  }

  Widget buildCloseButton(Color? textColor) {
    return CustomTextButton(
      closeButtonTitle,
      onTap: () {
        if (context != null) {
          ScaffoldMessenger.of(context).clearSnackBars();
        }
      },
      textColor: textColor ?? Colors.white,
    );
  }

  Icon buildIcon(IconData? icon, Color? textColor) {
    return Icon(
      icon,
      color: textColor ?? Colors.white,
    );
  }
}
