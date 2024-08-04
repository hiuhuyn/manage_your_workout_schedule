// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:manage_your_workout_schedule/repository/notification_repository.dart';
import 'package:manage_your_workout_schedule/screens/widgets/set_notification_training.dart';

import '../../model/notification_training.dart';

class NotificationTrainingController extends ChangeNotifier {
  List<NotificationTraining> notifications = [];
  final repository = NotificationTrainingRepository();

  void loadTraining(BuildContext context) async {
    try {
      notifications = await repository.getAllNotifications();
      notifyListeners();
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(e.toString()),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

  void addTraining(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        scrollable: true,
        title: const Text("Thêm thông báo"),
        content: SetNotificationTrainingWidget(
          onSubmit: (value) async {
            Navigator.pop(context, value);
          },
        ),
      ),
    ).then(
      (value) async {
        if (value is NotificationTraining) {
          try {
            value.id = await repository.insertNotification(value);
            notifications.add(value);
            notifyListeners();
          } catch (e) {
            // ignore: use_build_context_synchronously
            showAboutDialog(context: context, children: [
              Text('Error adding new notification training: $e'),
            ]);
          }
        }
      },
    );
  }

  void updateTraining(
      BuildContext context, NotificationTraining notification) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        scrollable: true,
        title: const Text("Cập nhật thông báo"),
        content: SetNotificationTrainingWidget(
          value: notification,
          onSubmit: (value) async {
            Navigator.pop(context, value);
          },
        ),
      ),
    ).then(
      (value) async {
        if (value is NotificationTraining) {
          try {
            await repository.updateNotification(value);
            int index = notifications.indexWhere(
              (element) => element.id == notification.id,
            );
            if (index != -1) {
              notifications[index] = value;
            } else {
              notifications.add(value);
            }
            notifyListeners();
          } catch (e) {
            // ignore: use_build_context_synchronously
            showAboutDialog(context: context, children: [
              Text('Error update notification training: $e'),
            ]);
          }
        }
      },
    );
  }

  void deleteTraining(BuildContext context, int id) async {
    try {
      await repository.deleteNotification(id);
      int index = notifications.indexWhere(
        (element) => element.id == id,
      );
      if (index != -1) {
        notifications.removeAt(index);
      }
      notifyListeners();
    } catch (e) {
      // ignore: use_build_context_synchronously
      showAboutDialog(context: context, children: [
        Text('Error delete notification training: $e'),
      ]);
    }
  }

  void scheduleAlarm(DateTime dateTime) async {
    int alarmId = 0;
    // await AndroidAlarmManager.oneShotAt(
    //   dateTime,
    //   alarmId,
    //   callback,
    //   exact: true,
    //   wakeup: true,
    // );
  }

  static Future<void> callback() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Scheduled Notification',
      'This is a scheduled notification.',
      platformChannelSpecifics,
      payload: 'item x',
    );

    // Gọi hàm mong muốn ở đây
    yourCustomFunction();
  }

  static void yourCustomFunction() {
    // Code của hàm bạn muốn gọi
    print('Custom function is called!');
  }
}
