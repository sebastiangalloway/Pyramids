import 'package:isar/isar.dart';

part 'task.g.dart';

@Collection()
//TODO remove isCompleted if unused and rebuild
class Task {
  Id id = Isar.autoIncrement;
  String title;
  bool isCompleted = false;
  int difficulty = 1; // Default difficulty = 1

  Task({required this.title, this.difficulty = 1});
}
