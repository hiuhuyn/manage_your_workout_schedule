import 'package:flutter/material.dart';
import 'package:manage_your_workout_schedule/screens/widgets/item_training_schedule.dart';
import 'package:provider/provider.dart';

import 'controllers/training_schedule_management_controller.dart';

class TrainingScheduleManagementScreen extends StatefulWidget {
  const TrainingScheduleManagementScreen({super.key});

  @override
  State<TrainingScheduleManagementScreen> createState() =>
      _TrainingScheduleManagementScreenState();
}

class _TrainingScheduleManagementScreenState
    extends State<TrainingScheduleManagementScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TrainingScheduleManagementController>().loadSchedules(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Text(
            'Quản lý lịch tập',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Expanded(
            child: Consumer<TrainingScheduleManagementController>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.trainingSchedules.length,
                  itemBuilder: (context, index) {
                    return ItemTrainingSchedule(
                        value: value.trainingSchedules[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          context
              .read<TrainingScheduleManagementController>()
              .addTrainingSchedule(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
