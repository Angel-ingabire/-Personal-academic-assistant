import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../models/assignment_model.dart';

/// Single assignment row used in lists.
///
/// Displays assignment information with interactive controls for:
/// - Marking as completed (checkbox)
/// - Editing assignment
/// - Deleting assignment
/// - Priority badge display
class AssignmentTile extends StatelessWidget {
  const AssignmentTile({
    super.key,
    required this.assignment,
    this.onToggleCompleted,
    this.onTapEdit,
    this.onDelete,
  });

  final Assignment assignment;
  final ValueChanged<bool?>? onToggleCompleted;
  final VoidCallback? onTapEdit;
  final VoidCallback? onDelete;

  Color _getPriorityColor() {
    switch (assignment.priority) {
      case 'High':
        return AppColors.warningRed;
      case 'Low':
        return AppColors.successGreen;
      default:
        return AppColors.accentYellow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox
          Checkbox(
            value: assignment.isCompleted,
            activeColor: AppColors.aluRed,
            checkColor: Colors.white,
            side: const BorderSide(color: AppColors.textSecondary),
            onChanged: onToggleCompleted,
          ),

          // Assignment info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  assignment.title,
                  style: TextStyle(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    decoration: assignment.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                const SizedBox(height: 4),

                // Course name
                Text(
                  assignment.courseName,
                  style: TextStyle(
                    color: AppColors.textDark.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),

                // Due date and priority
                Row(
                  children: [
                    // Priority badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getPriorityColor().withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: _getPriorityColor().withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        assignment.priority,
                        style: TextStyle(
                          color: _getPriorityColor(),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Due date
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: AppColors.textDark.withOpacity(0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Due ${DateFormat('MMM dd').format(assignment.dueDate)}',
                      style: TextStyle(
                        color: AppColors.textDark.withOpacity(0.6),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (onTapEdit != null)
                IconButton(
                  icon: Icon(
                    Icons.edit_outlined,
                    color: AppColors.textDark.withOpacity(0.6),
                    size: 20,
                  ),
                  onPressed: onTapEdit,
                  tooltip: 'Edit',
                ),
              if (onDelete != null)
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppColors.aluRed,
                    size: 20,
                  ),
                  onPressed: onDelete,
                  tooltip: 'Delete',
                ),
            ],
          ),
        ],
      ),
    );
  }
}
