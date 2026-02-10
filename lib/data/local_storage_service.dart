import 'package:shared_preferences/shared_preferences.dart';

/// Lightweight wrapper around [SharedPreferences].
///
/// Central place for accessing raw JSON blobs for different features.
/// Higher‑level repositories should build on top of this service so that
/// widgets do not interact with [SharedPreferences] directly.
class LocalStorageService {
  LocalStorageService._(this._prefs);

  final SharedPreferences _prefs;

  static Future<LocalStorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalStorageService._(prefs);
  }

  // Keys shared across the app. These are aligned with the existing
  // Assignments feature which already stores under the `assignments` key.
  static const _assignmentsKey = 'assignments';
  static const _sessionsKey = 'sessions';
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

