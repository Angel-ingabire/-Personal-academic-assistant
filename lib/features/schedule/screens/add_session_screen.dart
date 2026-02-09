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
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Session Title *'),
              validator: (v) => v!.isEmpty ? 'Enter a title' : null,
              onSaved: (v) => _title = v!,
            ),
            const SizedBox(height: 20),
            // Date Picker Trigger
            ListTile(
              title: Text("Date: ${_selectedDate.toLocal()}".split(' ')[0]),
              trailing: const Icon(Icons.calendar_today, color: AppColors.aluRed),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2027),
                );
                if (picked != null) setState(() => _selectedDate = picked);
              },
            ),
            // Session Type Dropdown
            DropdownButtonFormField<SessionType>(
              value: _type,
              items: SessionType.values.map((type) {
                return DropdownMenuItem(value: type, child: Text(type.name.toUpperCase()));
              }).toList(),
              onChanged: (v) => setState(() => _type = v!),
              decoration: const InputDecoration(labelText: 'Session Type'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.aluRed),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // TODO: Pass this back to your Provider/Database
                  final newSession = Session(
                    id: DateTime.now().toString(),
                    title: _title,
                    date: _selectedDate,
                    startTime: _combine(_selectedDate, _startTime),
                    endTime: _combine(_selectedDate, _endTime),
                    type: _type,
                  );
                  Navigator.pop(context, newSession);
                }
              },
              child: const Text('Save Session', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}