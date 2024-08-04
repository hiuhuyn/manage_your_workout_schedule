import 'package:flutter/material.dart';
import 'package:manage_your_workout_schedule/screens/home_screen.dart';
import 'package:manage_your_workout_schedule/screens/login_screen.dart';
import 'package:provider/provider.dart';

import 'screens/controllers/exercise_controller.dart';
import 'screens/controllers/training_schedule_management_controller.dart';

void main() {
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
