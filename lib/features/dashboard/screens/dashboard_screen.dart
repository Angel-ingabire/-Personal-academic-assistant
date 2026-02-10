import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/attendance_logic.dart';
import '../../../core/widgets/alu_card.dart';
import '../../assignments/models/assignment_model.dart';
import '../../schedule/models/session_model.dart';
import '../widgets/warning_indicator.dart';

/// Tab 1: Home Dashboard – today's date, academic week, course filter,
/// at-risk warning, summary cards, today's classes, assignments due in 7 days.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _selectedCourse = 'All Selected Courses';
  late DashboardData _data;

  static const List<String> _courseOptions = [
    'All Selected Courses',
    'Introduction to Python Programming',
    'Front End Web Development',
    'Introduction to Linux',
  ];

  @override
  void initState() {
    super.initState();
    _data = DashboardData.sample();
  }

  void _onCourseTap() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Text(
                'Select course',
                style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ..._courseOptions.map((course) {
                final isSelected = course == _selectedCourse;
                return ListTile(
                  title: Text(
                    course,
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: AppColors.aluRed)
                      : null,
                  onTap: () {
                    setState(() => _selectedCourse = course);
                    Navigator.pop(context);
                  },
                );
              }),
              SizedBox(height: MediaQuery.paddingOf(context).bottom + 8),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final width = MediaQuery.sizeOf(context).width;
    final horizontalPadding = (padding.horizontal + 4).clamp(12.0, 20.0);
    final topPadding = (padding.top + 8).clamp(12.0, 20.0);
    final bottomPadding = padding.bottom + 16;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary, size: 20),
          onPressed: () {},
        ),
        title: const Text('Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(horizontalPadding, topPadding, horizontalPadding, bottomPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DateAndWeekHeader(
              date: _data.currentDate,
              academicWeek: _data.academicWeek,
            ),
            SizedBox(height: width < 360 ? 12 : 16),
            _CourseDropdown(
              selectedCourse: _selectedCourse,
              onTap: _onCourseTap,
            ),
            SizedBox(height: width < 360 ? 12 : 16),
            WarningIndicator(
              isAtRisk: AttendanceLogic.isAtRisk(_data.attendancePercentage),
              attendancePercentage: _data.attendancePercentage,
            ),
            SizedBox(height: width < 360 ? 12 : 16),
            _SummaryRow(
              activeProjects: _data.activeProjectsCount,
              codeSessions: _data.codeSessionsCount,
              upcoming: _data.upcomingCount,
            ),
            SizedBox(height: 24),
            Text(
              "Today's Classes",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            _TodayList(
              todaySessions: _data.todaySessions,
              assignmentsDueSoon: _data.assignmentsDueInSevenDays,
            ),
          ],
        ),
      ),
    );
  }
}

class _DateAndWeekHeader extends StatelessWidget {
  const _DateAndWeekHeader({
    required this.date,
    required this.academicWeek,
  });

  final DateTime date;
  final int academicWeek;

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('EEEE, MMMM d').format(date);
    final isNarrow = MediaQuery.sizeOf(context).width < 360;

    return AluCard(
      padding: EdgeInsets.symmetric(
        horizontal: isNarrow ? 12 : 16,
        vertical: isNarrow ? 10 : 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateStr,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Academic Week $academicWeek',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.accentYellow.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Week $academicWeek',
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseDropdown extends StatelessWidget {
  const _CourseDropdown({
    required this.selectedCourse,
    required this.onTap,
  });

  final String selectedCourse;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AluCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              selectedCourse,
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 15,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.activeProjects,
    required this.codeSessions,
    required this.upcoming,
  });

  final int activeProjects;
  final int codeSessions;
  final int upcoming;

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < 360;
    final spacing = (isNarrow ? 8.0 : 12.0);

    return Row(
      children: [
        Expanded(
          child: _SummaryCard(value: '$activeProjects', label: 'Active Projects'),
        ),
        SizedBox(width: spacing),
        Expanded(
          child: _SummaryCard(value: '$codeSessions', label: 'Code Sessions'),
        ),
        SizedBox(width: spacing),
        Expanded(
          child: _SummaryCard(value: '$upcoming', label: 'Upcoming'),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final isNarrow = MediaQuery.sizeOf(context).width < 360;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isNarrow ? 10 : 14,
        horizontal: isNarrow ? 6 : 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.darkCardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary.withValues(alpha: 0.85),
              fontSize: isNarrow ? 9 : 12,
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

class _TodayList extends StatelessWidget {
  const _TodayList({
    required this.todaySessions,
    required this.assignmentsDueSoon,
  });

  final List<Session> todaySessions;
  final List<Assignment> assignmentsDueSoon;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('HH:mm');
    final dueFormat = DateFormat('MMM d');

    final sessionTiles = todaySessions.map((s) {
      final start = dateFormat.format(s.startTime);
      final end = dateFormat.format(s.endTime);
      return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          s.title.toUpperCase(),
          style: const TextStyle(
            color: AppColors.textDark,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '$start - $end',
          style: const TextStyle(color: AppColors.textDark, fontSize: 13),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textDark),
        onTap: () {},
      );
    }).toList();

    final assignmentTiles = assignmentsDueSoon.take(5).map((a) {
      return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          '${a.title} Due ${dueFormat.format(a.dueDate)}',
          style: const TextStyle(
            color: AppColors.textDark,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.textDark),
        onTap: () {},
      );
    }).toList();

    final allTiles = <Widget>[];
    for (var i = 0; i < sessionTiles.length; i++) {
      allTiles.add(sessionTiles[i]);
      if (i < sessionTiles.length - 1) allTiles.add(const Divider(height: 1));
    }
    if (sessionTiles.isNotEmpty && assignmentTiles.isNotEmpty) {
      allTiles.add(const Divider(height: 1));
    }
    for (var i = 0; i < assignmentTiles.length; i++) {
      allTiles.add(assignmentTiles.elementAt(i));
      if (i < assignmentTiles.length - 1) allTiles.add(const Divider(height: 1));
    }

    if (allTiles.isEmpty) {
      return AluCard(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'No sessions or assignments due today.',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return AluCard(
      padding: EdgeInsets.zero,
      child: Column(children: allTiles),
    );
  }
}

/// Dashboard data: sessions, assignments, counts, attendance.
class DashboardData {
  DashboardData({
    required this.currentDate,
    required this.academicWeek,
    required this.attendancePercentage,
    required this.activeProjectsCount,
    required this.codeSessionsCount,
    required this.upcomingCount,
    required this.todaySessions,
    required this.assignmentsDueInSevenDays,
  });

  final DateTime currentDate;
  final int academicWeek;
  final double attendancePercentage;
  final int activeProjectsCount;
  final int codeSessionsCount;
  final int upcomingCount;
  final List<Session> todaySessions;
  final List<Assignment> assignmentsDueInSevenDays;

  static DashboardData sample() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Academic week (e.g. 1–14)
    final startOfYear = DateTime(now.year, 1, 1);
    final days = today.difference(startOfYear).inDays;
    final weekOfYear = (days / 7).floor() + 1;
    final academicWeek = weekOfYear.clamp(1, 14);

    final todaySessions = [
      Session(
        id: '1',
        title: 'ASSIGNMENT',
        date: today,
        startTime: DateTime(today.year, today.month, today.day, 9, 0),
        endTime: DateTime(today.year, today.month, today.day, 10, 30),
        type: SessionType.classSession,
      ),
      Session(
        id: '2',
        title: 'Quiz 1',
        date: today,
        startTime: DateTime(today.year, today.month, today.day, 11, 0),
        endTime: DateTime(today.year, today.month, today.day, 11, 30),
        type: SessionType.classSession,
      ),
    ];

    final assignments = [
      Assignment(
        id: 'a1',
        title: 'Assignment 1',
        dueDate: today.add(const Duration(days: 2)),
        courseName: 'Python Programming',
        priority: 'High',
        isCompleted: false,
      ),
      Assignment(
        id: 'a2',
        title: 'Assignment 2',
        dueDate: today.add(const Duration(days: 5)),
        courseName: 'Web Development',
        priority: 'Medium',
        isCompleted: false,
      ),
      Assignment(
        id: 'a3',
        title: 'Group Project Mobile App (Flutter)',
        dueDate: today.add(const Duration(days: 6)),
        courseName: 'Flutter Development',
        priority: 'High',
        isCompleted: false,
      ),
    ];

    final sevenDaysFromNow = today.add(const Duration(days: 7));
    final assignmentsDueInSevenDays = assignments
        .where((a) => !a.isCompleted && !a.dueDate.isBefore(today) && a.dueDate.isBefore(sevenDaysFromNow))
        .toList();

    final pendingCount = assignments.where((a) => !a.isCompleted).length;

    return DashboardData(
      currentDate: now,
      academicWeek: academicWeek,
      attendancePercentage: 72.0,
      activeProjectsCount: 4,
      codeSessionsCount: 7,
      upcomingCount: pendingCount.clamp(1, 99),
      todaySessions: todaySessions,
      assignmentsDueInSevenDays: assignmentsDueInSevenDays,
    );
  }
}
