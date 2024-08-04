import 'package:flutter/material.dart';

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
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
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
      child: ListTile(
        title: Text(formatDateTime(widget.value.start)),
        onTap: () {
          setState(() {
            isSelect = !isSelect;
          });
        },
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
        selected: isSelect,
        subtitle: isSelect
            ? ListView.builder(
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
              )
            : null,
      ),
    );
  }
}
