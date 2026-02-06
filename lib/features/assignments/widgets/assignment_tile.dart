import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../models/assignment_model.dart';

/// Single assignment row used in lists.
///
/// This is intentionally simple; Member A can extend with swipe actions,
/// priority chips, etc.
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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: assignment.isCompleted,
        activeColor: AppColors.aluRed,
        onChanged: onToggleCompleted,
      ),
      title: Text(
        assignment.title,
        style: TextStyle(
          color: Colors.white,
          decoration:
              assignment.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Text(
        assignment.courseName,
        style: const TextStyle(color: AppColors.textSecondary),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onTapEdit != null)
            IconButton(
              icon: const Icon(Icons.edit, color: AppColors.textSecondary),
              onPressed: onTapEdit,
            ),
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: AppColors.aluRed),
              onPressed: onDelete,
            ),
        ],
      ),
    );
  }
}

