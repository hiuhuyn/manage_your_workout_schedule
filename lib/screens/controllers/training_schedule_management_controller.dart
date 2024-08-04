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

  void updateTrainingSchedule(
      BuildContext context, TrainingSchedule schedule) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        scrollable: true,
        title: const Text("Cập nhật lịch tập"),
        content: SetTrainingScheduleWidget(
          value: schedule,
          onSubmit: (value) async {
            Navigator.pop(context, value);
          },
        ),
      ),
    ).then(
      (value) async {
        if (value is TrainingSchedule) {
          try {
            await _trainingScheduleRepository.updateTrainingSchedule(value);
            int index = _trainingSchedules.indexWhere(
              (element) => element.id == value.id,
            );
            if (index != -1) {
              _trainingSchedules[index] = value;
            } else {
              _trainingSchedules.add(value);
            }
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

  void deleteTrainingSchedule(BuildContext context, int id) async {
    try {
      await _trainingScheduleRepository.deleteTrainingSchedule(id);
      _trainingSchedules.removeWhere((element) => element.id == id);
      notifyListeners();
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text("Lỗi xóa: $e"),
            actions: <Widget>[
              TextButton(child: const Text("OK"), onPressed: () {})
            ]),
      );
    }
  }
}
