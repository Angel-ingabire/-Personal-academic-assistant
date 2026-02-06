import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/alu_card.dart';
import 'add_session_screen.dart';

/// Tab 3: Calendar & Sessions view.
///
/// Structure matches UI design with:
/// - Weekly calendar view
/// - List of scheduled sessions
/// - Attendance recording for each session
///
/// TODO(Member B): Implement schedule screen with:
/// - Weekly schedule displaying all sessions
/// - View scheduled sessions
/// - Record attendance for each session (Present/Absent toggle)
/// - Remove scheduled sessions when cancelled
/// - Modify session details if arrangements change
class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  void _openAddSession(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AddSessionScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accentYellow,
        foregroundColor: AppColors.textDark,
        onPressed: () => _openAddSession(context),
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Add calendar/week view widget here
            const Text(
              'Weekly Schedule',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            // TODO: Replace with actual sessions from data source
            AluCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Today\'s Sessions',
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'No sessions scheduled for today',
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
