import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/timer_logic/timer_cubit.dart';
import '../dialogs/settings_dialog.dart';

class TimerContextMenu extends StatelessWidget {
  const TimerContextMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GenericContextMenu(
      buttonConfigs: [
        ContextMenuButtonConfig(
          'Skip Cycle',
          onPressed: () => context.read<TimerCubit>().nextCycle(),
        ),
        ContextMenuButtonConfig(
          'Reset Timer',
          onPressed: () => context.read<TimerCubit>().resetTimer(),
        ),
        ContextMenuButtonConfig(
          'Preferences',
          onPressed: () => _onSettingsClicked(context),
        )
      ],
    );
  }

  Future<void> _onSettingsClicked(BuildContext context) async {
    final cubit = context.read<TimerCubit>();
    final hasSaved = await showDialog<bool>(
      context: context,
      builder: (context) {
        return const SettingsDialog();
      },
    );
    if (hasSaved ?? false) {
      cubit.initTimes();
      await cubit.resetTimer();
    }
  }
}
