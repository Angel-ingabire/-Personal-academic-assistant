import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../models/session_model.dart';

/// Card representation of a scheduled academic session.
class SessionCard extends StatelessWidget {
  const SessionCard({
    super.key,
    required this.session,
    this.onToggleAttendance,
    this.onTapEdit,
    this.onDelete,
  });

  final Session session;
  final VoidCallback? onToggleAttendance;
  final VoidCallback? onTapEdit;
  final VoidCallback? onDelete;

  String _sessionTypeLabel(SessionType type) {
    switch (type) {
      case SessionType.classSession:
        return 'Class';
      case SessionType.masterySession:
        return 'Mastery Session';
      case SessionType.studyGroup:
        return 'Study Group';
      case SessionType.pslMeeting:
        return 'PSL Meeting';
    }
  }

  Color _attendanceColor(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.present:
        return AppColors.successGreen;
      case AttendanceStatus.absent:
        return AppColors.aluRed;
      case AttendanceStatus.unknown:
        return AppColors.accentYellow;
    }
  }

  String _attendanceLabel(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.present:
        return 'Present';
      case AttendanceStatus.absent:
        return 'Absent';
      case AttendanceStatus.unknown:
        return 'Mark';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  session.title,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textSecondary),
                    onPressed: onDelete,
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              _sessionTypeLabel(session.type),
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${session.startTime.hour.toString().padLeft(2, '0')}:${session.startTime.minute.toString().padLeft(2, '0')}'
                  ' - '
                  '${session.endTime.hour.toString().padLeft(2, '0')}:${session.endTime.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(color: AppColors.textDark),
                ),
                if (session.location != null)
                  Text(
                    session.location!,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (onTapEdit != null)
                  TextButton.icon(
                    onPressed: onTapEdit,
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Edit'),
                  ),
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: _attendanceColor(session.attendanceStatus),
                    foregroundColor: Colors.black,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  onPressed: onToggleAttendance,
                  child: Text(_attendanceLabel(session.attendanceStatus)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

