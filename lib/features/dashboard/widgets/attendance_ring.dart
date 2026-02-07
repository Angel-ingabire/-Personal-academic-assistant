import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// Simple circular indicator for overall attendance.
///
/// Member C can replace this with a more advanced custom painter if desired.
class AttendanceRing extends StatelessWidget {
  const AttendanceRing({
    super.key,
    required this.percentage,
  });

  final double percentage;

  @override
  Widget build(BuildContext context) {
    final clamped = percentage.clamp(0, 100);
    final isAtRisk = clamped < 75;

    return SizedBox(
      height: 120,
      width: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: clamped / 100,
            strokeWidth: 10,
            backgroundColor: AppColors.borderGrey,
            valueColor: AlwaysStoppedAnimation<Color>(
              isAtRisk ? AppColors.aluRed : AppColors.successGreen,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${clamped.toStringAsFixed(0)}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Attendance',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

