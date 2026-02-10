import 'package:flutter/material.dart';

import '../providers/attendance_provider.dart';

/// Banner-style alert when attendance drops below 75%.
///
/// This can later be replaced or wired into the dashboard's
/// `WarningIndicator`, but is kept local to avoid conflicts.
class AttendanceAlert extends StatelessWidget {
  const AttendanceAlert({
    super.key,
    required this.provider,
  });

  final AttendanceProvider provider;

  @override
  Widget build(BuildContext context) {
    if (!provider.isBelowThreshold) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        '⚠️ Warning: Attendance below 75%',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

