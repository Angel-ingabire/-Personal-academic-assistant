import 'package:flutter/material.dart';

import '../models/attendance_model.dart';
import '../providers/attendance_provider.dart';

/// Simple Present / Absent toggle for a single date.
///
/// Intended to be embedded in session or day views.
class AttendanceToggle extends StatelessWidget {
  const AttendanceToggle({
    super.key,
    required this.date,
    required this.provider,
  });

  final DateTime date;
  final AttendanceProvider provider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            provider.markAttendance(date, AttendanceStatus.present);
          },
          child: const Text('Present'),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            provider.markAttendance(date, AttendanceStatus.absent);
          },
          child: const Text('Absent'),
        ),
      ],
    );
  }
}

