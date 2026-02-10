import 'package:flutter/material.dart';

/// Simple attendance status for a given date.
enum AttendanceStatus {
  present,
  absent,
}

/// Represents a single attendance record for a specific calendar day.
@immutable
class AttendanceRecord {
  const AttendanceRecord({
    required this.date,
    required this.status,
  });

  /// Calendar day this record applies to (time component ignored).
  final DateTime date;

  /// Whether the student was present or absent.
  final AttendanceStatus status;
}

