import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Reusable ALU-branded card used across features.
///
/// Keeps padding, elevation, and rounded corners consistent.
class AluCard extends StatelessWidget {
  const AluCard({
    super.key,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    required this.child,
  });

  final VoidCallback? onTap;
  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground, // White cards matching UI design
        borderRadius: BorderRadius.circular(12),
      ),
      padding: padding,
      child: child,
    );

    if (onTap == null) return card;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: card,
    );
  }
}

