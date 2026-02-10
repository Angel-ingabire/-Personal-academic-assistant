class AttendanceHistoryScreen extends StatelessWidget {
  final AttendanceProvider provider;

  const AttendanceHistoryScreen({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: provider.records.length,
      itemBuilder: (context, index) {
        final record = provider.records[index];

        return ListTile(
          title: Text(
            "${record.date.day}/${record.date.month}/${record.date.year}",
          ),
          trailing: Text(
            record.status == AttendanceStatus.present
                ? "Present"
                : "Absent",
            style: TextStyle(
              color: record.status == AttendanceStatus.present
                  ? Colors.green
                  : Colors.red,
            ),
          ),
        );
      },
    );
  }
}

