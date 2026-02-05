class Assignment {
  final String id;
  final String title;
  final String courseName;
  final DateTime dueDate;
  final String priority; 
  bool isCompleted;

  Assignment({
    required this.id,
    required this.title,
    required this.courseName,
    required this.dueDate,
    this.priority = 'Medium', 
    this.isCompleted = false,
  });
}