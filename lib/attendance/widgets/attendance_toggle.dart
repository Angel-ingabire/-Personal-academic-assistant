class AttendanceToggle extends StatelessWidget {
  final DateTime date;
  final AttendanceProvider provider;

  const AttendanceToggle({
    super.key,
    required this.date,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            provider.markAttendance(date, AttendanceStatus.present);
          },
          child: const Text("Present"),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            provider.markAttendance(date, AttendanceStatus.absent);
          },
          child: const Text("Absent"),
        ),
      ],
    );
  }
}

