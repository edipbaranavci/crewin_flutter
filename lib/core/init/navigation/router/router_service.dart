import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../features/views/home/view/home_view.dart';
import '../../../../features/views/splash/splash_view.dart';
import '../enums/router_enums.dart';

class RouterService {
  static RouterService? _instance;
  // Avoid self isntance
  RouterService._();
  static RouterService get instance {
    _instance ??= RouterService._();
    return _instance!;
  }

  static GoRoute _goRoute(RouterEnums enums, Widget widget) {
    return GoRoute(
      path: enums.routeName,
      name: enums.routeName,
      builder: (context, state) => widget,
    );
  }

  final router = GoRouter(
    routes: [
      _goRoute(RouterEnums.splashView, const SplashView()),
      _goRoute(RouterEnums.homeView, const HomeView()),
    ],
    initialLocation: RouterEnums.splashView.routeName,
  );
}
