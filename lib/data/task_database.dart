import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pyramids/models/task.dart';
import 'package:pyramids/models/pyramid_brick.dart';

class TaskDatabase extends ChangeNotifier {
  static final TaskDatabase _instance =
      TaskDatabase._internal(); // ✅ Define Singleton
  factory TaskDatabase() => _instance;

  TaskDatabase._internal() {
    fetchTasks();
    fetchBricks();
  }

  static late Isar isar;

  // ✅ Initialize database and ensure data is fetched before UI builds
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [TaskSchema, PyramidBrickSchema],
      directory: dir.path,
    );

    // ✅ Ensure tasks & bricks are loaded before app starts
    await _instance.fetchTasks();
    await _instance.fetchBricks();
  }

  // Lists for tasks and pyramid bricks
  final List<Task> currentTasks = [];
  final List<PyramidBrick> pyramidBricks = [];

  // Create and add tasks
  Future<void> addTask(String userNewTitle) async {
    final newTask = Task(title: userNewTitle);
    await isar.writeTxn(() async {
      isar.tasks.put(newTask);
    });
    await fetchTasks(); // ✅ Ensure UI updates
  }

  // Read tasks
  Future<void> fetchTasks() async {
    List<Task> fetchedTasks = await isar.tasks.where().findAll();
    currentTasks.clear();
    currentTasks.addAll(fetchedTasks);
    notifyListeners();
  }

  // Read bricks
  Future<void> fetchBricks() async {
    List<PyramidBrick> fetchedBricks =
        await isar.pyramidBricks.where().findAll();
    pyramidBricks.clear();
    pyramidBricks.addAll(fetchedBricks);
    notifyListeners();
  }

  // Convert a defeated enemy (task) into a pyramid brick
  Future<void> defeatTask(int id) async {
    final existingTask = await isar.tasks.get(id);
    if (existingTask != null) {
      await isar.writeTxn(() async {
        await isar.pyramidBricks
            .put(PyramidBrick(title: existingTask.title)); // Convert to brick
        await isar.tasks.delete(id); // Remove from task list
      });
      await fetchTasks();
      await fetchBricks();
    }
  }

  // Edit a task
  Future<void> editTask(int id, String newTitle) async {
    final existingTask = await isar.tasks.get(id);
    if (existingTask != null) {
      existingTask.title = newTitle;
      await isar.writeTxn(() async {
        isar.tasks.put(existingTask);
      });
      await fetchTasks();
    }
  }

  // Mark task as complete
  Future<void> checkTask(int id) async {
    final existingTask = await isar.tasks.get(id);
    if (existingTask != null) {
      existingTask.isCompleted = !existingTask.isCompleted;
      await isar.writeTxn(() async {
        isar.tasks.put(existingTask);
      });
      await fetchTasks();
    }
  }

  // Delete a task
  Future<void> deleteTask(int id) async {
    await isar.writeTxn(() async {
      isar.tasks.delete(id);
    });
    await fetchTasks();
  }
}
