import 'package:flutter/material.dart';
import 'package:manage_your_workout_schedule/screens/controllers/training_schedule_management_controller.dart';
import 'package:provider/provider.dart';

import '../../model/training_schedule.dart';
import '../../unit.dart';

class ItemTrainingSchedule extends StatefulWidget {
  ItemTrainingSchedule({super.key, required this.value});
  TrainingSchedule value;

  @override
  State<ItemTrainingSchedule> createState() => _ItemTrainingScheduleState();
}

class _ItemTrainingScheduleState extends State<ItemTrainingSchedule> {
  bool isSelect = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelect = !isSelect;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: isSelect ? Border.all(color: Colors.blue) : null,
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                spreadRadius: 3.0,
              )
            ]),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 30,
                  color: Colors.blue,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    formatDateTime(widget.value.start!),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      context
                          .read<TrainingScheduleManagementController>()
                          .updateTrainingSchedule(context, widget.value);
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      context
                          .read<TrainingScheduleManagementController>()
                          .deleteTrainingSchedule(context, widget.value.id!);
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
            Visibility(
              visible: isSelect,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.value.exerciseList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.value.exerciseList[index].name),
                    onTap: () {},
                    subtitle:
                        Text(widget.value.exerciseList[index].count.toString()),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                    leading: const Icon(Icons.fitness_center),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
