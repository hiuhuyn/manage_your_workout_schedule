import 'package:flutter/material.dart';
import 'package:manage_your_workout_schedule/screens/exercise_management_screen.dart';
import 'package:manage_your_workout_schedule/screens/notidication_screen.dart';

import 'training_schedule_management_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;
  final PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            _selectedTab = value;
          });
        },
        controller: _pageController,
        children: const [
          ExerciseManagementScreen(),
          NotidicationScreen(),
          TrainingScheduleManagementScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), label: 'Bài tập'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Thông báo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Lịch tập'),
        ],
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            _selectedTab = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear);
          });
        },
      ),
    );
  }
}
