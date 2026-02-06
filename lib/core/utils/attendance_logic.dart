/// Shared attendance-related logic used across features.
class AttendanceLogic {
  /// Returns attendance as a percentage in the range 0–100.
  static double calculatePercentage({
    required int attendedSessions,
    required int totalSessions,
  }) {
    if (totalSessions == 0) return 0;
    final value = (attendedSessions / totalSessions) * 100;
    return double.parse(value.toStringAsFixed(1));
  }

  /// Returns whether the student is at risk based on a 75% threshold.
  static bool isAtRisk(double percentage) => percentage < 75.0;
}

