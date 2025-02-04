import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/saved_task.dart';
import 'settings_screen.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO coloring of this scaffold isnt consistent with main_home_screens
    return Scaffold(
      //backgroundColor: SettingsScreen().colorSetting,
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
                  //TODO remove tasks and add task to history of tasks completed and credit rewards or exp
                  Checkbox(
                    value: task.tasks[index].isCompleted,
                    onChanged: (_) {
                      context.read<SaveTask>().checkTask(index);
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<SaveTask>().removeTask(
                            task.tasks[index],
                          );
                    },
                    icon: const Icon(
                      Icons.delete,
                    ),
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
