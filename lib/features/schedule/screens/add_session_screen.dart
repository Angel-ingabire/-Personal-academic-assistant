import 'package:flutter/material.dart';
import '../models/session_model.dart';
import '../../../core/constants/app_colors.dart';

class AddSessionScreen extends StatefulWidget {
  const AddSessionScreen({super.key});

  @override
  State<AddSessionScreen> createState() => _AddSessionScreenState();
}

class _AddSessionScreenState extends State<AddSessionScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Form State
  String _title = '';
  String? _location;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 30);
  SessionType _type = SessionType.classSession;

  // Logic to combine Date and Time for the Model
  DateTime _combine(DateTime date, TimeOfDay time) =>
      DateTime(date.year, date.month, date.day, time.hour, time.minute);

  // Helper to build high-contrast time pickers
  Widget _buildTimeTile(String label, TimeOfDay time, bool isStart) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: time,
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Color.fromARGB(255, 2, 50, 95), // Header background
                      onPrimary: Colors.white, // Header text
                      onSurface: Colors.black, // Body text
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null) {
              setState(() {
                if (isStart) _startTime = picked; else _endTime = picked;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time.format(context),
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
                const Icon(Icons.access_time, color: Color.fromARGB(255, 2, 50, 95)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background for contrast
      appBar: AppBar(
        title: const Text('New Academic Session'),
        backgroundColor: Color.fromARGB(255, 2, 50, 95),
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Section Title
            const Text(
              "Session Details",
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Title Input
            TextFormField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Session Title *',
                labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                hintText: 'e.g. Software Engineering Class',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              validator: (v) => v!.isEmpty ? 'Enter a title' : null,
              onSaved: (v) => _title = v!,
            ),
            const SizedBox(height: 20),

            // Date Selection
            const Text(
              "Date",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black26),
                borderRadius: BorderRadius.circular(8),
              ),
              title: Text(
                "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                style: const TextStyle(color: Colors.black),
              ),
              trailing: const Icon(Icons.calendar_today, color:Color.fromARGB(255, 2, 50, 95)),
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
            const SizedBox(height: 20),

            // Time Selection Row
            Row(
              children: [
                Expanded(child: _buildTimeTile("Start Time", _startTime, true)),
                const SizedBox(width: 15),
                Expanded(child: _buildTimeTile("End Time", _endTime, false)),
              ],
            ),
            const SizedBox(height: 20),

            // Session Type Dropdown
            const Text(
              "Session Type",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<SessionType>(
              dropdownColor: Colors.white,
              style: const TextStyle(color: Colors.black),
              value: _type,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              items: SessionType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(type.name.replaceAll('Session', '').toUpperCase()),
                );
              }).toList(),
              onChanged: (v) => setState(() => _type = v!),
            ),
            const SizedBox(height: 20),

            // Location Input (Optional)
            TextFormField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Location (Optional)',
                labelStyle: const TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onSaved: (v) => _location = v,
            ),

            const SizedBox(height: 40),

            // Save Button
            SizedBox(
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 2, 50, 95),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    
                    final newSession = Session(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: _title,
                      location: _location,
                      date: _selectedDate,
                      startTime: _combine(_selectedDate, _startTime),
                      endTime: _combine(_selectedDate, _endTime),
                      type: _type,
                    );
                    Navigator.pop(context, newSession);
                  }
                },
                child: const Text(
                  'SAVE SESSION',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}