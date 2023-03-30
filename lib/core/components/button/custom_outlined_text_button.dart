import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomOutlinedTextButton extends StatelessWidget {
  const CustomOutlinedTextButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.textColor,
    this.elevation = 0,
    this.borderSide = BorderSide.none,
    this.style,
    this.borderColor,
    this.borderWidth,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String title;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderWidth;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double elevation;
  final BorderSide borderSide;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: padding ?? context.horizontalPaddingMedium,
          backgroundColor: backgroundColor ?? context.appTheme.primaryColor,
          foregroundColor: context.colorScheme.primary,
          side: BorderSide(
            color: borderColor ?? context.colorScheme.secondary,
            width: borderWidth ?? 1.7,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: context.lowBorderRadius,
          ),
          elevation: elevation,
        ),
        child: Text(
          title,
          style: style ??
              context.textTheme.labelLarge?.copyWith(
                color: textColor ?? context.colorScheme.onPrimary,
              ),
        ),
      ),
    );
  }
}
