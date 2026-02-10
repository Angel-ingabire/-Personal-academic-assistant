import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../models/assignment_model.dart';

/// Screen for creating or editing an assignment.
///
/// Features:
/// - Assignment title (required text field)
/// - Due date (date picker)
/// - Course name (text input)
/// - Priority level (High/Medium/Low dropdown)
/// - Form validation
class AddAssignmentScreen extends StatefulWidget {
  const AddAssignmentScreen({super.key, this.existingAssignment});

  final Assignment? existingAssignment;

  @override
  State<AddAssignmentScreen> createState() => _AddAssignmentScreenState();
}

class _AddAssignmentScreenState extends State<AddAssignmentScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _courseController;
  late DateTime _selectedDate;
  late String _selectedPriority;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.existingAssignment?.title ?? '');
    _courseController = TextEditingController(
        text: widget.existingAssignment?.courseName ?? '');
    _selectedDate = widget.existingAssignment?.dueDate ??
        DateTime.now().add(const Duration(days: 7));
    _selectedPriority = widget.existingAssignment?.priority ?? 'Medium';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _courseController.dispose();
    super.dispose();
  }

  void _saveAssignment() {
    if (_formKey.currentState!.validate()) {
      // Additional validation
      if (_selectedDate
          .isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
        setState(() {
          _errorText = 'Due date should not be in the past.';
        });
        return;
      }

      final assignment = Assignment(
        id: widget.existingAssignment?.id ?? DateTime.now().toString(),
        title: _titleController.text.trim(),
        courseName: _courseController.text.trim(),
        dueDate: _selectedDate,
        priority: _selectedPriority,
        isCompleted: widget.existingAssignment?.isCompleted ?? false,
      );

      Navigator.of(context).pop(assignment);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _errorText = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(widget.existingAssignment == null
            ? 'Create Assignment'
            : 'Edit Assignment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title field
              TextFormField(
                controller: _titleController,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  labelText: 'Assignment Title *',
                  labelStyle: const TextStyle(color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.darkCardBackground,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.borderGrey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.accentYellow),
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.warningRed),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Assignment title is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Course name field
              TextFormField(
                controller: _courseController,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  labelText: 'Course Name *',
                  labelStyle: const TextStyle(color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.darkCardBackground,
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.borderGrey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.accentYellow),
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.warningRed),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Course name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Priority dropdown
              const Text(
                'Priority',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedPriority,
                dropdownColor: AppColors.darkCardBackground,
                style:
                    const TextStyle(color: AppColors.textPrimary, fontSize: 16),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: AppColors.darkCardBackground,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.borderGrey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.accentYellow),
                  ),
                ),
                items: ['High', 'Medium', 'Low'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedPriority = newValue!;
                  });
                },
              ),
              const SizedBox(height: 30),

              // Due date picker
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Due Date',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        DateFormat('MMM dd, yyyy').format(_selectedDate),
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    label: const Text('Change Date'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkCardBackground,
                      foregroundColor: AppColors.accentYellow,
                    ),
                    onPressed: _pickDate,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Error message
              if (_errorText != null) ...[
                Text(
                  _errorText!,
                  style: const TextStyle(
                    color: AppColors.warningRed,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentYellow,
                    foregroundColor: AppColors.textDark,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _saveAssignment,
                  child: Text(
                    widget.existingAssignment == null
                        ? 'Create Assignment'
                        : 'Save Changes',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
