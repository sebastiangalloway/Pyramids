class Task {
  String title;
  DateTime deadline;
  bool isCompleted;

  Task({
    required this.title,
    required this.deadline,
    this.isCompleted = false,
  });

  void completeTask() {
    isCompleted = true;
  }
}
