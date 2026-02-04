class Assignment {
  String id;
  String title;
  String courseName;
  DateTime dueDate;
  bool isCompleted;

  Assignment({
    required this.id,
    required this.title,
    required this.courseName,
    required this.dueDate,
    this.isCompleted = false,
  });
}