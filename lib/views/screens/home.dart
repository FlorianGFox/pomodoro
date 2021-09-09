import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/core/platform.dart';
import 'package:pomodoro/views/widgets/context_menu.dart';
import 'package:pomodoro/views/widgets/windows_top_bar.dart';

import '../components/action_bar.dart';
import '../components/mac_os_bindings.dart';
import '../components/timer_info.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeScreenWidget = currentPlatformType == PlatformType.windows
        ? const _WindowsHomeScreen()
        : const _MacHomeScreen();

    return homeScreenWidget;
  }
}

class _WindowsHomeScreen extends StatelessWidget {
  const _WindowsHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WindowsTopBar(
        child: ContextMenuRegion(
          contextMenu: TimerContextMenu(),
          child: _Timer(),
        ),
      ),
    );
  }
}

class _MacHomeScreen extends StatelessWidget {
  const _MacHomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MacOsBindings(
      child: Scaffold(
        body: _Timer(),
      ),
    );
  }
}

class _Timer extends StatelessWidget {
  const _Timer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ActionBar(),
        Expanded(child: TimerInfo()),
      ],
    );
  }
}
