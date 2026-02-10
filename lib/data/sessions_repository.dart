import 'dart:convert';

import '../features/schedule/models/session_model.dart';
import 'local_storage_service.dart';

/// Repository responsible for persisting [Session]s and their attendance
/// status using [LocalStorageService].
class SessionsRepository {
  SessionsRepository._();

  static final SessionsRepository instance = SessionsRepository._();

  Future<List<Session>> loadSessions() async {
    final storage = await LocalStorageService.init();
    final jsonString = storage.getSessionsJson();
    if (jsonString == null || jsonString.isEmpty) {
      return <Session>[];
    }

    try {
      final decoded = jsonDecode(jsonString) as List<dynamic>;
      return decoded
          .map((item) => _sessionFromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return <Session>[];
    }
  }

  Future<void> saveSessions(List<Session> sessions) async {
    final storage = await LocalStorageService.init();
    final encoded =
        jsonEncode(sessions.map((session) => _sessionToJson(session)).toList());
    await storage.setSessionsJson(encoded);
  }

  Future<void> upsertSession(Session session) async {
    final current = await loadSessions();
    final index = current.indexWhere((s) => s.id == session.id);
    if (index >= 0) {
      current[index] = session;
    } else {
      current.add(session);
    }
    await saveSessions(current);
  }

  Future<void> deleteSession(String id) async {
    final current = await loadSessions();
    current.removeWhere((s) => s.id == id);
    await saveSessions(current);
  }

  /// Returns all sessions that occur on [day] (based on the `date` field).
  Future<List<Session>> sessionsForDay(DateTime day) async {
    final current = await loadSessions();
    final normalized = DateTime(day.year, day.month, day.day);
    return current.where((s) {
      final d = DateTime(s.date.year, s.date.month, s.date.day);
      return d == normalized;
    }).toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  /// Calculates a simple attendance ratio (0–1) based on how many sessions
  /// have [AttendanceStatus.present].
  Future<double> attendanceRatio() async {
    final current = await loadSessions();
    if (current.isEmpty) return 0;
    final presentCount = current
        .where((s) => s.attendanceStatus == AttendanceStatus.present)
        .length;
    return presentCount / current.length;
  }

  Map<String, dynamic> _sessionToJson(Session session) {
    return {
      'id': session.id,
      'title': session.title,
      'date': session.date.toIso8601String(),
      'startTime': session.startTime.toIso8601String(),
      'endTime': session.endTime.toIso8601String(),
      'location': session.location,
      'type': session.type.index,
      'attendanceStatus': session.attendanceStatus.index,
    };
  }

  Session _sessionFromJson(Map<String, dynamic> json) {
    final typeIndex = json['type'] as int? ?? 0;
    final attendanceIndex = json['attendanceStatus'] as int? ?? 0;

    return Session(
      id: json['id'] as String,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      location: json['location'] as String?,
      type: SessionType.values[typeIndex.clamp(0, SessionType.values.length - 1)],
      attendanceStatus: AttendanceStatus
          .values[attendanceIndex.clamp(0, AttendanceStatus.values.length - 1)],
    );
  }
}

