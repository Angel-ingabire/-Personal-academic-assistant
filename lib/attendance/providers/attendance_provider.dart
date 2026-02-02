import 'attendance_model.dart';

class AttendanceProvider {
  final List<AttendanceRecord> _records = [];

  List<AttendanceRecord> get records => _records;

  void markAttendance(DateTime date, AttendanceStatus status) {
    // Prevent duplicate dates
    _records.removeWhere(
      (record) => _isSameDay(record.date, date),
    );

    _records.add(
      AttendanceRecord(date: date, status: status),
    );
  }

  double get attendancePercentage {
    if (_records.isEmpty) return 100;

    final presentCount =
        _records.where((r) => r.status == AttendanceStatus.present).length;

    return (presentCount / _records.length) * 100;
  }

  bool get isBelowThreshold => attendancePercentage < 75;

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
  }
}

