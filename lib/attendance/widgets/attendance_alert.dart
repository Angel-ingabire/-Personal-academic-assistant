Widget attendanceAlert(AttendanceProvider provider) {
  if (!provider.isBelowThreshold) return const SizedBox.shrink();

  return Container(
    padding: const EdgeInsets.all(12),
    color: Colors.red.shade100,
    child: const Text(
      "⚠️ Warning: Attendance below 75%",
      style: TextStyle(color: Colors.red),
    ),
  );
}

