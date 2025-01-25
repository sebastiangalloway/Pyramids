import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/save_task_model.dart';
import '/models/task_model.dart';

class AddTask extends StatelessWidget {
  AddTask({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                context.read<SaveTask>().addTask(
                      Task(
                        title: controller.text,
                      ),
                    );
                controller.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-todo-screen');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
