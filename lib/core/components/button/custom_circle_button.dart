import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomCircleButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  const CustomCircleButton({
    Key? key,
    required this.child,
    required this.onTap,
    this.padding,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? context.colorScheme.secondary,
        padding: padding ?? context.paddingNormal,
        shape: const CircleBorder(),
      ),
      onPressed: onTap,
      child: child,
    );
  }
}
