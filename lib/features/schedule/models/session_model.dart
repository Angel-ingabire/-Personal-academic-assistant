/// Basic Session model used in schedule and attendance screens.
enum SessionType {
  classSession,
  masterySession,
  studyGroup,
  pslMeeting,
}

enum AttendanceStatus {
  unknown,
  present,
  absent,
}

class Session {
  Session({
    required this.id,
    required this.title,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.location,
    this.type = SessionType.classSession,
    this.attendanceStatus = AttendanceStatus.unknown,
  });

  final String id;
  final String title;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;
  final String? location;
  final SessionType type;
  final AttendanceStatus attendanceStatus;

  Session copyWith({
    String? id,
    String? title,
    DateTime? date,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
    SessionType? type,
    AttendanceStatus? attendanceStatus,
  }) {
    return Session(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      location: location ?? this.location,
      type: type ?? this.type,
      attendanceStatus: attendanceStatus ?? this.attendanceStatus,
    );
  }
}

