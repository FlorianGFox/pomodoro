import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'constants/color_constants.dart';
import 'core/desktop_window.dart';
import 'core/notifications.dart';
import 'injection/injection.dart';
import 'logic/settings_logic/settings_cubit.dart';
import 'logic/timer_logic/timer_cubit.dart';
import 'views/screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.dev);

  // Set up desktop windows. Does nothing if not on desktop.
  setUpDesktopWindow();

  // Initializes notifications for the current platform.
  await getIt.get<Notifications>().initialize();

  runApp(const Pomodoro());
}

class Pomodoro extends StatelessWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<TimerCubit>()..initTimes()),
        BlocProvider(
          create: (context) => getIt<SettingsCubit>()..getExistingTimes(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: primaryColor,
          ),
          fontFamily: 'Montserrat',
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<TimerCubit>()..initTimes()),
            BlocProvider(
              create: (context) => getIt<SettingsCubit>()..getExistingTimes(),
            ),
          ],
          child: ContextMenuOverlay(
            child: const HomeScreen(),
          ),
        ),
      ),
    );
  }
}
