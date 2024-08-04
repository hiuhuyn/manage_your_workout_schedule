import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:manage_your_workout_schedule/screens/home_screen.dart';
import 'package:manage_your_workout_schedule/screens/login_screen.dart';
import 'package:provider/provider.dart';

import 'screens/controllers/exercise_controller.dart';
import 'screens/controllers/notification_training_controller.dart';
import 'screens/controllers/training_schedule_management_controller.dart';
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the Alarm manager
  // await AndroidAlarmManager.initialize();

  // // Initialize the local notifications plugin
  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('@mipmap/ic_launcher');

  // const InitializationSettings initializationSettings =
  //     InitializationSettings(android: initializationSettingsAndroid);

  // await FlutterLocalNotificationsPlugin().initialize(initializationSettings);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return TrainingScheduleManagementController();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return ExerciseController();
          },
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return NotificationTrainingController();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            surface: Colors.white,
            seedColor: Colors.blue,
          ),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
