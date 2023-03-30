import '../../../core/init/navigation/enums/router_enums.dart';
import '../../../core/init/navigation/router/router_service.dart';
import 'cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (context) => SplashCubit(),
      child: const _SplashView(),
    );
  }
}

class _SplashView extends StatelessWidget {
  const _SplashView({Key? key}) : super(key: key);
  final String title = 'Crewin Flutter - Food App';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state.isLoaded) {
              RouterService.instance.router.go(RouterEnums.homeView.routeName);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title, style: context.textTheme.titleLarge),
              context.emptySizedHeightBoxHigh,
              const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
