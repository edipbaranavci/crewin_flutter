import 'core/init/navigation/router/router_service.dart';
import 'core/init/theme/custom_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/main_cubit.dart';
import 'firebase_options.dart';

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> main() async {
  await _init();
  runApp(BlocProvider(
    create: (context) => MainCubit(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final String title = 'Crewin Flutter Food App';

  @override
  Widget build(BuildContext context) {
    final router = RouterService.instance.router;
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return BlocProvider.value(
          value: context.read<MainCubit>(),
          child: MaterialApp.router(
            routerDelegate: router.routerDelegate,
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            debugShowCheckedModeBanner: false,
            theme: CustomTheme.instance.getThemeData(context),
            title: title,
          ),
        );
      },
    );
  }
}
