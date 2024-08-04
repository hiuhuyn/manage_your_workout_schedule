import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../model/exercise.dart';
import '../controllers/exercise_controller.dart';

class SetExerciseWidget extends StatefulWidget {
  SetExerciseWidget({super.key, this.exercise});
  Exercise? exercise;
  @override
  State<SetExerciseWidget> createState() => _SetExerciseWidgetState();
}

class _SetExerciseWidgetState extends State<SetExerciseWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController countController = TextEditingController();
  String? errorName;
  String? errorCount;
  Exercise? exercise;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.exercise?.name ?? '');
    countController =
        TextEditingController(text: widget.exercise?.count.toString() ?? '');
    exercise = widget.exercise;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(exercise == null ? 'Thêm Bài Tập' : 'Sửa Bài Tập'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: nameController,
            keyboardType: TextInputType.text,
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  errorName = "Vui lòng nhập tên bài tập.";
                } else {
                  errorName = null;
                }
              });
            },
            decoration: InputDecoration(
              hintText: "Nhập tên bài tập...",
              labelText: "Tên bài tập",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              errorText: errorName,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: countController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  errorCount = "Vui lòng nhập số lần.";
                } else {
                  errorCount = null;
                }
              });
            },
            maxLength: 10,
            decoration: InputDecoration(
              hintText: "Nhập số lần...",
              labelText: "Số lần",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              errorText: errorCount,
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Hủy'),
        ),
        TextButton(
          onPressed: () async {
            if (nameController.text.isEmpty) {
              setState(() {
                errorName = "Vui lòng nhập tên bài tập.";
              });
              return;
            } else if (countController.text.isEmpty) {
              setState(() {
                errorCount = "Vui lòng nhập số lần.";
              });
              return;
            }
            final name = nameController.text;
            final count = int.tryParse(countController.text) ?? 0;

            if (exercise == null) {
              context
                  .read<ExerciseController>()
                  .addExercise(Exercise(name: name, count: count), context);
            } else {
              context.read<ExerciseController>().updateExercise(
                    exercise!.copyWith(name: name, count: count),
                    context,
                  );
            }
            Navigator.pop(context);
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}
