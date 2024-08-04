import 'package:flutter/material.dart';
import 'package:manage_your_workout_schedule/screens/controllers/notification_training_controller.dart';
import 'package:manage_your_workout_schedule/screens/widgets/item_notification_training.dart';
import 'package:provider/provider.dart';

class NotidicationScreen extends StatefulWidget {
  const NotidicationScreen({super.key});

  @override
  State<NotidicationScreen> createState() => _NotidicationScreenState();
}

class _NotidicationScreenState extends State<NotidicationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotificationTrainingController>().loadTraining(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Quản lý thông báo',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Expanded(
              child: Consumer<NotificationTrainingController>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.notifications.length,
                    itemBuilder: (context, index) {
                      return ItemNotificationtTrainingWidget(
                          value: value.notifications[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.notification_add),
        onPressed: () {
          context.read<NotificationTrainingController>().addTraining(context);
        },
      ),
    );
  }
}
