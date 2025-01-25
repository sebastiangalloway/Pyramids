import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/entity.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Entity> _entities = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task, Entity entity) {
    _tasks.add(task);
    _entities.add(entity);
    notifyListeners();
  }

  void completeTask(Task task) {
    task.completeTask();
    notifyListeners();
  }

  void damageEntity(Entity entity, int damage) {
    entity.takeDamage(damage);
    notifyListeners();
  }
}
