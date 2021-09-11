import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../core/desktop_window.dart';
import '../../core/notifications.dart';
import '../../injection/injection.dart';
import '../../logic/timer_logic/timer_cubit.dart';
import '../widgets/cycle_indicator.dart';

class TimerInfo extends StatefulWidget {
  const TimerInfo({Key? key}) : super(key: key);

  @override
  _TimerInfoState createState() => _TimerInfoState();
}

class _TimerInfoState extends State<TimerInfo> {
  late Notifications notifications;

  @override
  void initState() {
    notifications = getIt.get<Notifications>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final timer = context.watch<TimerCubit>();
    final state = timer.state;
    final minutesStr =
        ((state.duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (state.duration % 60).floor().toString().padLeft(2, '0');

    return BlocListener<TimerCubit, TimerState>(
      listener: (context, state) async {
        if (state.status == TimerStatus.complete) {
          await _onComplete(state);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.maxFinite,
              child: FittedBox(
                child: Text(
                  '$minutesStr:$secondsStr',
                  maxLines: 1,
                  style: const TextStyle(
                      color: primaryColor,
                      fontSize: 86,
                      fontWeight: FontWeight.w900,
                      fontFeatures: [
                        FontFeature.tabularFigures(),
                      ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CycleIndicator(
                    cycles: state.cycles,
                    currentCycle: state.currentCycle,
                  ),
                  Text(
                    state.mode.asString.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onComplete(TimerState state) async {
    final message =
        !state.mode.isWork ? 'Time to take a break' : "Let's get back to work!";

    if (isWindowVisible()) {
      activateWindow();
      await notifications.playSound('audio/ding.mp3');
    } else {
      await notifications.show(
        title: 'Cycle completed',
        subtitle: 'Click to go back to the app',
        message: message,
      );
    }
  }
}
