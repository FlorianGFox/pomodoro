import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/color_constants.dart';
import '../../constants/size_constants.dart';
import '../../core/time_validator.dart';
import '../../logic/settings_logic/settings_cubit.dart';
import '../widgets/vertical_spacing.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  _SettingsDialogState createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  final _workController = TextEditingController();
  final _relaxController = TextEditingController();
  String? errorMessage;

  @override
  void initState() {
    final cubit = context.read<SettingsCubit>();
    if (cubit.state is SettingsLoaded) {
      updateTimes(cubit.state as SettingsLoaded);
    }
    cubit.getExistingTimes();
    super.initState();
  }

  void updateTimes(SettingsLoaded state) {
    final times = state.pomodoroTime;
    final workTime = times.workTime ~/ 60;
    final restTime = times.restTime ~/ 60;
    _workController.text = '$workTime';
    _relaxController.text = '$restTime';
  }

  void _handleSave() {
    if (!TimeValidator.isValid(_workController.text) ||
        !TimeValidator.isValid(_relaxController.text)) {
      errorMessage = 'Invalid time';
    } else {
      errorMessage = null;
      context.read<SettingsCubit>().saveTimes(
            int.parse(_workController.text) * 60,
            int.parse(_relaxController.text) * 60,
          );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is SettingsLoaded) {
          updateTimes(state);
        } else if (state is SettingsSaved) {
          Navigator.of(context).pop(true);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.only(
          left: 30,
          top: 30,
          right: 30,
          bottom: 20,
        ),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: FittedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TimeInput(
                  title: 'Work Time: ',
                  hint: '25',
                  controller: _workController,
                  autofocus: true,
                ),
                TimeInput(
                  title: 'Relax Time: ',
                  hint: '05',
                  controller: _relaxController,
                  autofocus: true,
                ),
                const VerticalSpacing(10),
                Row(
                  children: [
                    SizedBox(
                      width: 170,
                      child: ElevatedButton(
                        onPressed: _handleSave,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.hovered)) {
                              return const Color.fromRGBO(140, 255, 205, 1);
                            }
                            return const Color.fromRGBO(34, 214, 169, 1);
                          }),
                        ),
                        child: const Text(
                          'SAVE',
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      errorMessage ?? '',
                      style: TextStyle(
                        color: Colors.redAccent.shade200,
                        fontSize: 13,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _workController.dispose();
    _relaxController.dispose();
    super.dispose();
  }
}

class TimeInput extends StatelessWidget {
  const TimeInput({
    Key? key,
    this.autofocus = false,
    required this.controller,
    required this.title,
    required this.hint,
  }) : super(key: key);

  final TextEditingController controller;
  final String title;
  final bool autofocus;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: settingsTextSize,
            fontWeight: FontWeight.w900,
            height: 0.7,
          ),
        ),
        SizedBox(
          width: 60,
          child: TextField(
            autofocus: autofocus,
            controller: controller,
            cursorColor: lightCyan,
            style: const TextStyle(
              color: Color.fromRGBO(140, 255, 205, 1),
              fontSize: settingsTextSize,
              fontWeight: FontWeight.w900,
              // height: 0.7,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(2),
              FilteringTextInputFormatter.allow(RegExp('[0-9]'))
            ],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.white24,
                fontSize: settingsTextSize,
                fontWeight: FontWeight.w900,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
