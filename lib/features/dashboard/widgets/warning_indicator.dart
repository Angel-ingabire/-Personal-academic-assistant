import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// Visual warning banner when attendance falls below 75% (▲ ATRISK WARNING).
class WarningIndicator extends StatelessWidget {
  const WarningIndicator({
    super.key,
    required this.isAtRisk,
    this.attendancePercentage,
  });

  final bool isAtRisk;
  final double? attendancePercentage;

  @override
  Widget build(BuildContext context) {
    if (!isAtRisk) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.aluRed,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 28),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '▲ ATRISK WARNING',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                if (attendancePercentage != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    'Attendance at ${attendancePercentage!.toStringAsFixed(0)}% (below 75% threshold)',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.95),
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

