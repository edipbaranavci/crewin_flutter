import 'package:crewin_flutter/core/init/theme/app_colors.dart';
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
      backgroundColor: context.appTheme.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(context.mediumValue * .5),
        ),
      ),
      elevation: 0,
    );
  }

  Text buildTitle(BuildContext context) {
    return Text(
      pageTitle,
      style: context.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: context.colorScheme.onBackground,
      ),
    );
  }
}
