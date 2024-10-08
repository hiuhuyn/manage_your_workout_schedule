import 'package:flutter/material.dart';
import 'package:manage_your_workout_schedule/model/training_schedule.dart';
import 'package:manage_your_workout_schedule/screens/controllers/exercise_controller.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../../model/exercise.dart';
import '../../unit.dart';

// ignore: must_be_immutable
class SetTrainingScheduleWidget extends StatefulWidget {
  SetTrainingScheduleWidget({
    super.key,
    required this.onSubmit,
    this.value,
  });
  Function(TrainingSchedule value) onSubmit;
  TrainingSchedule? value;

  @override
  State<SetTrainingScheduleWidget> createState() =>
      _SetTrainingScheduleWidgetState();
}

class _SetTrainingScheduleWidgetState extends State<SetTrainingScheduleWidget> {
  TrainingSchedule trainingSchedule = TrainingSchedule(exerciseList: []);
  List<Exercise> exercises = [];

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      trainingSchedule = widget.value!;
    }
    exercises = context.read<ExerciseController>().exercises;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                )
              ]),
          child: GestureDetector(
            onTap: () {
              showDialogSelectTime(context);
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    trainingSchedule.start == null
                        ? "Chọn thời gian tập"
                        : formatDateTime(trainingSchedule.start!),
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.calendar_month)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 300,
          width: 500,
          child: ListView.builder(
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              bool valueCheckBox =
                  trainingSchedule.exerciseList.contains(exercises[index]);
              return Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      )
                    ]),
                child: ListTile(
                  leading: Checkbox(
                    value: valueCheckBox,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          trainingSchedule.exerciseList.add(exercises[index]);
                        } else {
                          trainingSchedule.exerciseList
                              .remove(exercises[index]);
                        }
                      });
                    },
                  ),
                  title: Text(exercises[index].name),
                  subtitle: Text(exercises[index].count.toString()),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Hủy'),
              ),
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  if (trainingSchedule.start == null) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Lỗi"),
                        content: const Text("Chưa chọn thời gian tập"),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Ok'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    widget.onSubmit(trainingSchedule);
                  }
                },
                child: const Text('Lưu'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showDialogSelectTime(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      initialDate: trainingSchedule.start,
      firstDate: now,
      lastDate: now.add(const Duration(days: 100)),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      selectableDayPredicate: (dateTime) {
        // Disallow selection of past dates
        if (dateTime.isBefore(DateTime(now.year, now.month, now.day))) {
          return false;
        }
        return true;
      },
    );

    if (dateTime != null) {
      // Check if the selected time is not in the past
      if (dateTime.isBefore(now)) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: const Text('Không thể chọn thời gian trong quá khứ.'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      } else {
        // Process the selected dateTime
        setState(() {
          trainingSchedule.start = dateTime;
        });
      }
    }
  }
}
