enum AttendanceStatus {
  present,
  absent,
}

class AttendanceRecord {
  final DateTime date;
  final AttendanceStatus status;

  AttendanceRecord({
    required this.date,
    required this.status,
  });
}

