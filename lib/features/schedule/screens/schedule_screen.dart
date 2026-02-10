import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/alu_card.dart';
import '../models/session_model.dart'; 
import '../widgets/session_card.dart'; 
import 'add_session_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  // Local list to manage sessions (Member B: Replace with Provider/DB later)
  List<Session> _sessions = [];

  void _openAddSession(BuildContext context) async {
    // Wait for the new session object from the AddSessionScreen
    final newSession = await Navigator.of(context).push<Session>(
      MaterialPageRoute(builder: (_) => const AddSessionScreen()),
    );

    if (newSession != null) {
      setState(() {
        _sessions.add(newSession);
        // Sort sessions by start time
        _sessions.sort((a, b) => a.startTime.compareTo(b.startTime));
      });
    }
  }

  void _toggleAttendance(String id) {
    setState(() {
      final index = _sessions.indexWhere((s) => s.id == id);
      if (index != -1) {
        final current = _sessions[index].attendanceStatus;
        final next = switch (current) {
          AttendanceStatus.unknown => AttendanceStatus.present,
          AttendanceStatus.present => AttendanceStatus.absent,
          AttendanceStatus.absent => AttendanceStatus.unknown,
        };
        _sessions[index] =
            _sessions[index].copyWith(attendanceStatus: next);
      }
    });
  }

  void _deleteSession(String id) {
    setState(() {
      _sessions.removeWhere((s) => s.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text('Schedule'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accentYellow,
        onPressed: () => _openAddSession(context),
        child: const Icon(Icons.add, color: Color.fromARGB(255, 6, 5, 5)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Weekly Schedule',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (_sessions.isEmpty)
            const AluCard(
              child: Text('No sessions scheduled. Tap + to add one!'),
            )
          else
            ..._sessions.map((session) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: SessionCard(
                    session: session,
                    onToggleAttendance: () => _toggleAttendance(session.id),
                    onDelete: () => _deleteSession(session.id),
                  ),
                )),
        ],
      ),
    );
  }
}