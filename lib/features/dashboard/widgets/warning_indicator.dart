import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// Visual warning banner when attendance falls below 75%.
class WarningIndicator extends StatelessWidget {
  const WarningIndicator({
    super.key,
    required this.isAtRisk,
  });

  final bool isAtRisk;

  @override
  Widget build(BuildContext context) {
    if (!isAtRisk) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.aluRed, // Red background matching UI design
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: const [
          Icon(Icons.warning_amber_rounded, color: Colors.white),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              '▲ ATRISK WARNING',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

