import 'package:equatable/equatable.dart';

class PomodoroTime extends Equatable {
  const PomodoroTime({
    required this.workTime,
    required this.restTime,
  });

  final int workTime;
  final int restTime;

  @override
  List<Object?> get props => [workTime, restTime];
}
