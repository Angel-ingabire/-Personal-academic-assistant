import '../models/attendance_model.dart';

/// In-memory attendance tracker used by the attendance feature.
///
/// This is intentionally simple so it can later be wired into
/// shared storage (e.g. `data/local_storage_service.dart` or
/// `data/database_helper.dart`) without changing its API.
class AttendanceProvider {
  final List<AttendanceRecord> _records = [];

  List<AttendanceRecord> get records => List.unmodifiable(_records);

  /// Mark attendance for a given calendar [date].
  ///
  /// Any existing record for that day is replaced.
  void markAttendance(DateTime date, AttendanceStatus status) {
    _records.removeWhere(
      (record) => _isSameDay(record.date, date),
    );

    _records.add(
      AttendanceRecord(date: date, status: status),
    );
  }

  /// Returns overall attendance percentage (0–100).
  double get attendancePercentage {
    if (_records.isEmpty) return 100;

    final presentCount =
        _records.where((r) => r.status == AttendanceStatus.present).length;

    return (presentCount / _records.length) * 100;
  }

  /// Whether attendance is below the 75% threshold.
  bool get isBelowThreshold => attendancePercentage < 75;

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

