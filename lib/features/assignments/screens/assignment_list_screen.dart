import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/alu_card.dart';
import 'add_assignment_screen.dart';

/// Tab 2: Assignment list and entry point for CRUD operations.
///
/// Structure matches UI design with:
/// - Filter tabs (All, Formative, Summative)
/// - Yellow "Create Group Assignment" button
/// - List of assignment cards
///
/// TODO(Member A): Implement full assignment management functionality:
/// - View all assignments sorted by due date
/// - Create new assignments
/// - Mark assignments as completed
/// - Remove assignments
/// - Edit assignment details
class AssignmentListScreen extends StatefulWidget {
  const AssignmentListScreen({super.key});

  @override
  State<AssignmentListScreen> createState() => _AssignmentListScreenState();
}

class _AssignmentListScreenState extends State<AssignmentListScreen> {
  String _selectedFilter = 'All'; // All, Formative, Summative

  void _openAddAssignment() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AddAssignmentScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
      ),
      body: Column(
        children: [
          // Filter tabs
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _FilterTab(
                  label: 'All',
                  isSelected: _selectedFilter == 'All',
                  onTap: () => setState(() => _selectedFilter = 'All'),
                ),
                const SizedBox(width: 16),
                _FilterTab(
                  label: 'Formative',
                  isSelected: _selectedFilter == 'Formative',
                  onTap: () => setState(() => _selectedFilter = 'Formative'),
                ),
                const SizedBox(width: 16),
                _FilterTab(
                  label: 'Summative',
                  isSelected: _selectedFilter == 'Summative',
                  onTap: () => setState(() => _selectedFilter = 'Summative'),
                ),
              ],
            ),
          ),

          // Create Group Assignment button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentYellow,
                  foregroundColor: AppColors.textDark,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _openAddAssignment,
                child: const Text(
                  'Create Group Assignment',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),

          // Assignment list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // TODO: Replace with actual assignments from data source
                _AssignmentCard(
                  title: 'ASSIGNMENT 1',
                  subtitle: 'Assignment 1',
                  dueDate: 'Due Feb 26',
                ),
                const SizedBox(height: 12),
                _AssignmentCard(
                  title: 'ASSIGNMENT 2',
                  subtitle: 'Assignment 2',
                  dueDate: 'Due Feb 36',
                  tag: 'Remedial',
                ),
                const SizedBox(height: 12),
                _AssignmentCard(
                  title: 'Group Project Mobile App (Flutter)',
                  subtitle: 'Group Project Mobile App (Flutter)',
                  dueDate: 'Due Feb 20',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Filter tab widget matching UI design.
class _FilterTab extends StatelessWidget {
  const _FilterTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.accentYellow : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 3,
            width: 40,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.accentYellow : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

/// Assignment card widget matching UI design.
class _AssignmentCard extends StatelessWidget {
  const _AssignmentCard({
    required this.title,
    required this.subtitle,
    required this.dueDate,
    this.tag,
  });

  final String title;
  final String subtitle;
  final String dueDate;
  final String? tag;

  @override
  Widget build(BuildContext context) {
    return AluCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.textDark,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textDark),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              if (tag != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accentYellow,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    tag!,
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Text(
                dueDate,
                style: const TextStyle(
                  color: AppColors.textDark,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

