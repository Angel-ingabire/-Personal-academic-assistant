import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/attendance_logic.dart';
import '../../../data/assignments_repository.dart';
import '../../../data/sessions_repository.dart';
import '../../schedule/models/session_model.dart';

/// Your Risk Status screen – attendance %, assignment status %, average score %, Get Help.
class YourRiskStatusScreen extends StatefulWidget {
  const YourRiskStatusScreen({super.key});

  @override
  State<YourRiskStatusScreen> createState() => _YourRiskStatusScreenState();
}

class _YourRiskStatusScreenState extends State<YourRiskStatusScreen> {
  int _attendancePercent = 0;
  int _assignmentStatusPercent = 0;
  int _averageScorePercent = 63; // Placeholder – no grades model yet.
  bool _isLoading = true;

  static const String _userName = 'Alex';

  @override
  void initState() {
    super.initState();
    _loadMetrics();
  }

  Future<void> _loadMetrics() async {
    final assignments = await AssignmentsRepository.instance.loadAssignments();
    final sessions = await SessionsRepository.instance.loadSessions();

    // Attendance percentage based on sessions marked as present.
    final totalSessions = sessions.length;
    final attendedSessions = sessions
        .where((s) => s.attendanceStatus == AttendanceStatus.present)
        .length;
    final attendancePercentage = AttendanceLogic.calculatePercentage(
      attendedSessions: attendedSessions,
      totalSessions: totalSessions,
    );

    // Assignment completion percentage based on completed vs total.
    final totalAssignments = assignments.length;
    final completedAssignments =
        assignments.where((a) => a.isCompleted).length;
    final assignmentStatusPercent = totalAssignments == 0
        ? 0
        : ((completedAssignments / totalAssignments) * 100).round();

    setState(() {
      _attendancePercent = attendancePercentage.round();
      _assignmentStatusPercent = assignmentStatusPercent;
      // _averageScorePercent left as-is for now.
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text('Your Risk Status'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          16,
          8,
          16,
          MediaQuery.paddingOf(context).bottom + 100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Hello $_userName At Risk',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _MetricBox(
                    value: '$_attendancePercent%',
                    label: 'Attendance',
                    color: AppColors.aluRed,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MetricBox(
                    value: '$_assignmentStatusPercent%',
                    label: 'Assignment Status',
                    color: AppColors.accentYellow,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MetricBox(
                    value: '$_averageScorePercent%',
                    label: 'Average Score',
                    color: AppColors.aluRed,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _onGetHelp(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentYellow,
                  foregroundColor: AppColors.textDark,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Get Help',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onGetHelp(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Get Help',
              style: TextStyle(
                color: AppColors.textDark,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Contact your academic advisor or visit the student support centre for assistance. You can also access online resources and tutoring from the campus portal.',
              style: TextStyle(
                color: AppColors.textDark,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.aluRed,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Close'),
              ),
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom + 8),
          ],
        ),
      ),
    );
  }
}

class _MetricBox extends StatelessWidget {
  const _MetricBox({
    required this.value,
    required this.label,
    required this.color,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: color == AppColors.accentYellow
                  ? AppColors.textDark
                  : Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
