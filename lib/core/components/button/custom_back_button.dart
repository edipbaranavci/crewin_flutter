import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomBackButton extends StatelessWidget {
  final IconData? iconData;
  final VoidCallback? onTap;
  final Color? color;
  final double? size;
  final String? toolTip;
  const CustomBackButton({
    Key? key,
    this.iconData,
    this.onTap,
    this.color,
    this.size,
    this.toolTip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: context.lowBorderRadius,
      onTap: onTap ?? () => Navigator.maybePop(context),
      child: Padding(
        padding: context.paddingLow,
        child: Tooltip(
          message: toolTip ?? 'Geri',
          child: Icon(
            iconData ?? Icons.chevron_left,
            size: size,
            color: color ?? context.colorScheme.onBackground,
          ),
        ),
      ),
    );
  }
}
