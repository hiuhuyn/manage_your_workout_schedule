import 'package:flutter/material.dart';
import 'package:manage_your_workout_schedule/model/notification_training.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../unit.dart';

// ignore: must_be_immutable
class SetNotificationTrainingWidget extends StatefulWidget {
  SetNotificationTrainingWidget({
    super.key,
    required this.onSubmit,
    this.value,
  });
  Function(NotificationTraining value) onSubmit;
  NotificationTraining? value;

  @override
  State<SetNotificationTrainingWidget> createState() =>
      _SetNotificationTrainingWidgetState();
}

class _SetNotificationTrainingWidgetState
    extends State<SetNotificationTrainingWidget> {
  NotificationTraining notificationTraining = NotificationTraining();
  String? errorName;

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      notificationTraining = widget.value!;
    }
    if (notificationTraining.name == null) {
      errorName = "Vui lòng nhâp tên thông báo";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.text,
          initialValue: notificationTraining.name,
          onChanged: (value) {
            notificationTraining.name = value;
            setState(() {
              if (value.isEmpty) {
                errorName = "Vui lòng nhập tên thông báo.";
              } else {
                errorName = null;
              }
            });
          },
          decoration: InputDecoration(
            hintText: "Nhập tên thông báo...",
            labelText: "Tên thông báo",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            errorText: errorName,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 8),
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
                    notificationTraining.start == null
                        ? "Chọn thời gian thông báo"
                        : formatDateTime(notificationTraining.start!),
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
                  if (notificationTraining.name == null ||
                      notificationTraining.name!.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Lỗi"),
                        content: const Text("Chưa nhập tên thông báo"),
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
                  } else if (notificationTraining.start == null) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Lỗi"),
                        content: const Text("Chưa chọn thời gian thông báo"),
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
                    widget.onSubmit(notificationTraining);
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
      initialDate: notificationTraining.start,
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
          notificationTraining.start = dateTime;
        });
      }
    }
  }
}
