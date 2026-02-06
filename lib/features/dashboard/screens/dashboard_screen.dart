import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/alu_card.dart';
import '../widgets/warning_indicator.dart';

/// Tab 1: Home Dashboard overview screen.
///
/// Structure matches UI design with:
/// - Course filter dropdown at top
/// - ATRISK WARNING banner
/// - Summary cards (Active Projects, Code Sessions, Upcoming)
/// - Today's Classes section
///
/// TODO(Member C): Implement full functionality:
/// - Today's date and current academic week
/// - List of today's scheduled academic sessions
/// - Assignments due within the next seven days
/// - Current overall attendance percentage
/// - Visual warning indicator when attendance falls below 75%
/// - Summary count of pending assignments
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () {}, // TODO: Navigate to profile
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course filter dropdown
            AluCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'All Selected Courses',
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(Icons.expand_more, color: AppColors.textDark),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ATRISK WARNING banner
            const WarningIndicator(isAtRisk: true), // TODO: Calculate from actual attendance
            const SizedBox(height: 16),

            // Summary cards row
            Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    value: '4',
                    label: 'Active Projects',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    value: '7',
                    label: 'Code Sessions',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    value: '1',
                    label: 'Upcoming',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Today's Classes section
            const Text(
              "Today's Classes",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            // TODO: Replace with actual today's sessions
            AluCard(
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      'ASSIGNMENT',
                      style: TextStyle(color: AppColors.textDark),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {}, // TODO: Navigate to assignment details
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text(
                      'Quiz 1',
                      style: TextStyle(color: AppColors.textDark),
                    ),
                    onTap: () {}, // TODO: Navigate to quiz details
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text(
                      'Assignment 2 Due Feb 26',
                      style: TextStyle(color: AppColors.textDark),
                    ),
                    onTap: () {}, // TODO: Navigate to assignment details
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

/// Summary card widget matching the UI design (dark blue with white text).
class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkCardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
