import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class PowerBadge extends StatelessWidget {
  final int? powerKw;
  final bool? isFastCharger;

  const PowerBadge({
    super.key,
    this.powerKw,
    this.isFastCharger,
  });

  @override
  Widget build(BuildContext context) {
    final isFast = isFastCharger == true;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isFast
            ? AppTheme.fastCharger.withValues(alpha: 0.12)
            : AppTheme.electricBlue.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isFast ? Icons.bolt_rounded : Icons.electric_bolt_outlined,
            size: 14,
            color: isFast ? AppTheme.fastCharger : AppTheme.electricBlue,
          ),
          const SizedBox(width: 4),
          Text(
            powerKw != null ? '$powerKw kW' : '—',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isFast ? AppTheme.fastCharger : AppTheme.electricBlue,
            ),
          ),
        ],
      ),
    );
  }
}
