import 'package:flutter/material.dart';

/// Screen for scheduling new academic sessions.
///
/// TODO(Member B): Implement form with:
/// - Session title (required text field)
/// - Date (date picker)
/// - Start time (time picker)
/// - End time (time picker)
/// - Location (optional text field)
/// - Session type (select from: Class, Mastery Session, Study Group, PSL Meeting)
class AddSessionScreen extends StatelessWidget {
  const AddSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Session'),
      ),
      body: const Center(
        child: Text(
          'Add Session Form\n(Member B to implement)',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
