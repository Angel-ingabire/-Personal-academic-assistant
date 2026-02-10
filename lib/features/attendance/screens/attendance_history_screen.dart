import 'package:flutter/material.dart';

import '../models/attendance_model.dart';
import '../providers/attendance_provider.dart';

/// Simple list view of all recorded attendance.
///
/// Intended as a building block that Member B/C can plug into
/// schedule or dashboard flows.
class AttendanceHistoryScreen extends StatelessWidget {
  const AttendanceHistoryScreen({
    super.key,
    required this.provider,
  });

  final AttendanceProvider provider;

  @override
  Widget build(BuildContext context) {
    final records = provider.records;

    if (records.isEmpty) {
      return const Center(
        child: Text('No attendance records yet.'),
      );
    }

    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, index) {
        final record = records[index];
        final date = record.date;
        final statusLabel =
            record.status == AttendanceStatus.present ? 'Present' : 'Absent';
        final statusColor =
            record.status == AttendanceStatus.present ? Colors.green : Colors.red;

        return ListTile(
          title: Text('${date.day}/${date.month}/${date.year}'),
          trailing: Text(
            statusLabel,
            style: TextStyle(color: statusColor),
          ),
        );
      },
    );
  }
}

