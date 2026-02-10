/// Assignment model used across the app.
/// Supports CRUD operations with local storage persistence.
class Assignment {
  Assignment({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.courseName,
    this.priority = 'Medium',
    this.isCompleted = false,
  });

  final String id;
  final String title;
  final DateTime dueDate;
  final String courseName;
  final String priority; // High / Medium / Low
  bool isCompleted;

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

  /// Convert Assignment to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'courseName': courseName,
      'dueDate': dueDate.toIso8601String(),
      'priority': priority,
      'isCompleted': isCompleted,
    };
  }

  /// Create Assignment from JSON
  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'] as String,
      title: json['title'] as String,
      courseName: json['courseName'] as String,
      dueDate: DateTime.parse(json['dueDate'] as String),
      priority: json['priority'] as String? ?? 'Medium',
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
}
