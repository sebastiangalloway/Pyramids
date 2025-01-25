import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/save_task_model.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-task-screen');
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<SaveTask>(builder: (context, task, child) {
        return ListView.builder(
          //TODO use later for managing max amount of tasks at a time
          itemCount: task.tasks.length,
          itemBuilder: (BuildContext context, index) {
            return ListTile(
              title: Text(task.tasks[index].title),
              trailing: Wrap(
                children: [
                  Checkbox(
                    value: task.tasks[index].isCompleted,
                    onChanged: (_) {
                      context.read<SaveTask>().checkTask(index);
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
