import 'package:shared_preferences/shared_preferences.dart';

/// Lightweight wrapper around [SharedPreferences].
///
/// Member D can extend this with higher-level helpers or migrate to SQLite.
class LocalStorageService {
  LocalStorageService._(this._prefs);

  final SharedPreferences _prefs;

  static Future<LocalStorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalStorageService._(prefs);
  }

  // Example keys – can be adjusted by Member D.
  static const _assignmentsKey = 'assignments_json';
  static const _sessionsKey = 'sessions_json';
  static const _attendanceKey = 'attendance_json';

  String? getAssignmentsJson() => _prefs.getString(_assignmentsKey);
  Future<bool> setAssignmentsJson(String value) =>
      _prefs.setString(_assignmentsKey, value);

  String? getSessionsJson() => _prefs.getString(_sessionsKey);
  Future<bool> setSessionsJson(String value) =>
      _prefs.setString(_sessionsKey, value);

  String? getAttendanceJson() => _prefs.getString(_attendanceKey);
  Future<bool> setAttendanceJson(String value) =>
      _prefs.setString(_attendanceKey, value);
}

