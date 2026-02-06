import 'package:flutter/material.dart';

/// Screen for creating a new assignment.
///
/// TODO(Member A): Implement form with:
/// - Assignment title (required text field)
/// - Due date (date picker)
/// - Course name (text input)
/// - Priority level (optional: High/Medium/Low)
class AddAssignmentScreen extends StatelessWidget {
  const AddAssignmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Assignment'),
      ),
      body: const Center(
        child: Text(
          'Add Assignment Form\n(Member A to implement)',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

