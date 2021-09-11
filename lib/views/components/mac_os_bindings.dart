import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menubar/menubar.dart';
import 'package:provider/provider.dart';

import '../../logic/timer_logic/timer_cubit.dart';
import '../dialogs/settings_dialog.dart';

class SkipCycleIntent extends Intent {}

class ResetIntent extends Intent {}

class SettingsIntent extends Intent {}

class MacOsBindings extends StatefulWidget {
  const MacOsBindings({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  _MacOsBindingsState createState() => _MacOsBindingsState();
}

class _MacOsBindingsState extends State<MacOsBindings> {
  final _skipKeySet = LogicalKeySet(
    LogicalKeyboardKey.meta,
    LogicalKeyboardKey.keyS,
  );
  final _resetKeySet = LogicalKeySet(
    LogicalKeyboardKey.meta,
    LogicalKeyboardKey.keyR,
  );
  final _settingsKeySet = LogicalKeySet(
    LogicalKeyboardKey.meta,
    LogicalKeyboardKey.comma,
  );

  bool _settingsOpen = false;
  @override
  void initState() {
    setApplicationMenu([
      Submenu(
        label: 'Timer',
        children: [
          MenuItem(
            label: 'Skip Cycle',
            shortcut: _skipKeySet,
            onClicked: _onSkipCycleClicked,
          ),
          MenuItem(
            label: 'Reset Timer',
            shortcut: _resetKeySet,
            onClicked: _onResetClicked,
          ),
          const MenuDivider(),
          MenuItem(
            label: 'Preferences',
            shortcut: _settingsKeySet,
            onClicked: _onSettingsClicked,
          ),
        ],
      ),
    ]);
    super.initState();
  }

  void _onSkipCycleClicked() {
    context.read<TimerCubit>().nextCycle();
  }

  void _onResetClicked() {
    context.read<TimerCubit>().resetTimer();
  }

  Future<void> _onSettingsClicked() async {
    final timerCubit = context.read<TimerCubit>();
    if (!_settingsOpen) {
      _settingsOpen = true;
      final hasSaved = await showDialog<bool>(
        context: context,
        builder: (context) {
          return const SettingsDialog();
        },
      );
      if (hasSaved ?? false) {
        timerCubit.initTimes();
        await timerCubit.resetTimer();
      }
      _settingsOpen = false;
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      autofocus: true,
      shortcuts: {
        _skipKeySet: SkipCycleIntent(),
        _resetKeySet: ResetIntent(),
        _settingsKeySet: SettingsIntent(),
      },
      actions: {
        SkipCycleIntent: CallbackAction(onInvoke: (e) => _onSkipCycleClicked()),
        ResetIntent: CallbackAction(onInvoke: (e) => _onResetClicked()),
        SettingsIntent: CallbackAction(onInvoke: (e) => _onSettingsClicked()),
      },
      child: widget.child,
    );
  }
}
