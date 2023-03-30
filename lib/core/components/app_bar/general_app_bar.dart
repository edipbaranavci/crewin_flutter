import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class GeneralAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String pageTitle;
  final List<Widget>? actions;

  GeneralAppBar({Key? key, required this.pageTitle, this.actions})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        pageTitle,
        style: context.textTheme.titleLarge?.copyWith(
          color: context.colorScheme.primary,
        ),
      ),
      actions: actions,
      centerTitle: true,
    );
  }
}
