import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pyramids/models/task.dart';

class NoteDatabase {
  static late Isar isar;

  //init
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [TaskSchema],
      directory: dir.path,
    );
  }

  //list of notes
  final List<Task> currentTasks = [];

  //create and add tasks
  Future<void> addTask(String userNewTitle) async {
    // creates new task object
    final newTask = Task(title: userNewTitle);

    //save to db
    await isar.writeTxn(() async {
      isar.tasks.put(newTask);
    });

    //re-read from db
    fetchTasks();
  }

  //read
  Future<void> fetchTasks() async {
    List<Task> fetchedTasks = await isar.tasks.where().findAll();
    currentTasks.clear();
    currentTasks.addAll(fetchedTasks);
  }

  //update
  Future<void> updateTask(int id, String newTitle) async {
    final existingTask = await isar.tasks.get(id);
    if (existingTask != null) {
      existingTask.title = newTitle;
      await isar.writeTxn(() async {
        isar.tasks.put(existingTask);
      });
      await fetchTasks();
    }
  }

  //delete
  Future<void> deleteTasks(int id) async {
    await isar.writeTxn(() async {
      isar.tasks.delete(id);
    });
    await fetchTasks();
  }
}
