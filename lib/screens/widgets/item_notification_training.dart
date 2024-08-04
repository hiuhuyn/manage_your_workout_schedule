import 'package:flutter/material.dart';
import 'package:manage_your_workout_schedule/model/notification_training.dart';
import 'package:manage_your_workout_schedule/screens/controllers/notification_training_controller.dart';
import 'package:manage_your_workout_schedule/screens/controllers/training_schedule_management_controller.dart';
import 'package:provider/provider.dart';

import '../../model/training_schedule.dart';
import '../../unit.dart';

class ItemNotificationtTrainingWidget extends StatefulWidget {
  ItemNotificationtTrainingWidget({super.key, required this.value});
  NotificationTraining value;

  @override
  State<ItemNotificationtTrainingWidget> createState() =>
      _ItemNotificationtTrainingWidgetState();
}

class _ItemNotificationtTrainingWidgetState
    extends State<ItemNotificationtTrainingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              spreadRadius: 3.0,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.notifications,
                size: 30,
                color: Colors.black,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            widget.value.name.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              context
                                  .read<NotificationTrainingController>()
                                  .updateTraining(context, widget.value);
                            },
                            icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              context
                                  .read<NotificationTrainingController>()
                                  .deleteTraining(context, widget.value.id!);
                            },
                            icon: const Icon(Icons.delete)),
                      ],
                    ),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      formatDateTime(widget.value.start!),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
