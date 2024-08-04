import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manage_your_workout_schedule/screens/controllers/exercise_controller.dart';
import 'package:provider/provider.dart';

import '../model/exercise.dart';

class ExerciseManagementScreen extends StatefulWidget {
  const ExerciseManagementScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ExerciseManagementScreenState createState() =>
      _ExerciseManagementScreenState();
}

class _ExerciseManagementScreenState extends State<ExerciseManagementScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ExerciseController>().loadExercises(context);
  }

  void _showExerciseDialog({Exercise? exercise}) {
    final nameController = TextEditingController(text: exercise?.name ?? '');
    final countController =
        TextEditingController(text: exercise?.count.toString() ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(exercise == null ? 'Thêm Bài Tập' : 'Sửa Bài Tập'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Nhập tên bài tập...",
                labelText: "Tên bài tập",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
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
              maxLength: 10,
              decoration: InputDecoration(
                hintText: "Nhập số lần...",
                labelText: "Số lần",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
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
              final name = nameController.text;
              final count = int.tryParse(countController.text) ?? 0;

              if (exercise == null) {
                context
                    .read<ExerciseController>()
                    .addExercise(Exercise(name: name, count: count), context);
              } else {
                context.read<ExerciseController>().updateExercise(
                      exercise.copyWith(name: name, count: count),
                      context,
                    );
              }
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Quản Lý Bài Tập',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Expanded(
              child: Consumer<ExerciseController>(
                  builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = value.exercises[index];
                    return Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
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
                      child: ListTile(
                        leading: const Icon(Icons.fitness_center),
                        title: Text(exercise.name),
                        subtitle: Text('Số Lần: ${exercise.count}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _showExerciseDialog(exercise: exercise),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  value.deleteExercise(exercise, context),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showExerciseDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
