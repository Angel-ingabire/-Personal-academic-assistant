import 'package:flutter/material.dart';
import '../models/session_model.dart';
/// Screen for scheduling new academic sessions.
///
/// TODO(Member B): Implement form with:
/// - Session title (required text field)
/// - Date (date picker)
/// - Start time (time picker)
/// - End time (time picker)
/// - Location (optional text field)
/// - Session type (select from: Class, Mastery Session, Study Group, PSL Meeting)
// Inside add_session_screen.dart
class AddSessionScreen extends StatefulWidget {
  const AddSessionScreen({super.key});

  @override
  State<AddSessionScreen> createState() => _AddSessionScreenState();
}

class _AddSessionScreenState extends State<AddSessionScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 30);
  SessionType _type = SessionType.classSession;

  // Logic to combine Date and Time for the Model
  DateTime _combine(DateTime date, TimeOfDay time) =>
      DateTime(date.year, date.month, date.day, time.hour, time.minute);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Academic Session')),
      body: Form(
        key: _formKey,
 
      ),
    );
  }
}