import 'package:flutter/material.dart';
import 'package:manage_your_workout_schedule/screens/widgets/set_training_schedule.dart';

import '../../model/training_schedule.dart';
import '../../repository/training_schedule_repository.dart';

class TrainingScheduleManagementController extends ChangeNotifier {
  final TrainingScheduleRepository _trainingScheduleRepository =
      TrainingScheduleRepository();
  List<TrainingSchedule> _trainingSchedules = [];
  List<TrainingSchedule> get trainingSchedules => List.from(_trainingSchedules);

  void loadSchedules(BuildContext context) async {
    try {
      _trainingSchedules =
          await _trainingScheduleRepository.getAllTrainingSchedules();
      notifyListeners();
    } catch (e) {
      showAboutDialog(context: context, children: [
        Text('Error loading training schedules: $e'),
      ]);
    }
  }

  void addTrainingSchedule(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        scrollable: true,
        title: const Text("Thêm lịch tập"),
        content: SetTrainingScheduleWidget(
          onSubmit: (value) async {
            Navigator.pop(context, value);
          },
        ),
      ),
    ).then(
      (value) async {
        if (value is TrainingSchedule) {
          try {
            value.id =
                await _trainingScheduleRepository.insertTrainingSchedule(value);
            _trainingSchedules.add(value);
            notifyListeners();
          } catch (e) {
            // ignore: use_build_context_synchronously
            showAboutDialog(context: context, children: [
              Text('Error adding new training schedule: $e'),
            ]);
          }
        }
      },
    );
  }
}
