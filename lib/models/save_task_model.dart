import 'package:flutter/material.dart';
import 'task_model.dart';

class SaveTask extends ChangeNotifier {
  List<Task> _tasks = [
    Task(title: 'Learn Flutter'),
    Task(title: 'Drink Water'),
  ];

  List<Task> get tasks => _tasks;
}
