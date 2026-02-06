/// Basic Assignment model used across the app.
///
/// Member A can extend this with additional fields as needed.
class Assignment {
  Assignment({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.courseName,
    this.priority,
    this.isCompleted = false,
  });

  final String id;
  final String title;
  final DateTime dueDate;
  final String courseName;
  final String? priority; // High / Medium / Low / null
  final bool isCompleted;

  Assignment copyWith({
    String? id,
    String? title,
    DateTime? dueDate,
    String? courseName,
    String? priority,
    bool? isCompleted,
  }) {
    return Assignment(
      id: id ?? this.id,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      courseName: courseName ?? this.courseName,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

