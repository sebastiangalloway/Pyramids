import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '/models/task_database.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  //text controller to access user input
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //on app startup, fetch existing notes
    readTasks();
  }

  //create a task
  void createTask() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          //create button
          MaterialButton(onPressed: () {
            //add to db
            context.read<TaskDatabase>().addTask(textController.text);
          })
        ],
      ),
    );
  }

  void readTasks() {
    context.read<TaskDatabase>().fetchTasks();
  }

  void editTask(Task task) {
    //prefilled text
    textController.text = task.title;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Edit Task'),
              content: TextField(controller: textController),
              actions: [
                //create button
                MaterialButton(
                  onPressed: () {
                    context
                        .read<TaskDatabase>()
                        .editTask(task.id, textController.text);
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Update'),
                )
              ],
            ));
  }

  void deleteTask(int id) {
    context.read<TaskDatabase>().deleteTask(id);
  }

  void checkTask(int id) {
    context.read<TaskDatabase>().checkTask(id);
  }

  @override
  Widget build(BuildContext context) {
    //task database
    final taskDatabase = context.watch<TaskDatabase>();

    List<Task> currentTasks = taskDatabase.currentTasks;

    //TODO coloring of this scaffold isnt consistent with main_home_screens
    return Scaffold(
      /*
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      */
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-task-screen');
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: currentTasks.length,
        itemBuilder: (context, index) {
          final task = currentTasks[index];

          //TODO use later for managing max amount of tasks at a time
          return ListTile(
            title: Text(task.title),
            trailing: Wrap(
              children: [
                //TODO remove tasks and add completed tasks to history of tasks completed and credit rewards or exp
                Checkbox(
                  value: task.isCompleted,
                  onChanged: (_) {
                   context.read<TaskDatabase>().checkTask(task.id);
                  },
                ),
                //edit button
                IconButton(
                  onPressed: () => editTask(task),
                  icon: const Icon(Icons.edit),
                ),
                //delete button
                IconButton(
                  onPressed: () => deleteTask(task.id),
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/*
            trailing: Wrap(
              children: [
                //TODO remove tasks and add task to history of tasks completed and credit rewards or exp
                Checkbox(
                  value: task.isCompleted,
                  onChanged: (_) {
                    context.read<SaveTask>().checkTask(index);
                  },
                ),
                IconButton(
                  onPressed: () {
                    context.read<SaveTask>().removeTask(
                          task,
                        );
                  },
                  icon: const Icon(
                    Icons.delete,
                  ),
                ),
              ],
            ),
*/
