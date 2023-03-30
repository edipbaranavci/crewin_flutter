import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../button/custom_back_button.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String pageTitle;
  final VoidCallback? onBackTap;

  CustomAppBar({Key? key, required this.pageTitle, this.onBackTap})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Center(child: CustomBackButton(onTap: onBackTap)),
      title: buildTitle(context),
      backgroundColor: Colors.transparent,
      // centerTitle: true,
      elevation: 0,
    );
  }

  Text buildTitle(BuildContext context) {
    return Text(
      pageTitle,
      style: context.textTheme.titleLarge?.copyWith(
        color: context.colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
