import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';

enum BadgeTone { success, warning, error, info, neutral }

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.label,
    this.tone = BadgeTone.neutral,
  });

  final String label;
  final BadgeTone tone;

  Color get _color {
    switch (tone) {
      case BadgeTone.success:
        return kSuccess;
      case BadgeTone.warning:
        return kWarning;
      case BadgeTone.error:
        return kError;
      case BadgeTone.info:
        return kInfo;
      case BadgeTone.neutral:
        return kTextMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = _color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: c,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
