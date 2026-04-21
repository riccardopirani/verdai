import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';

class VerdantCard extends StatelessWidget {
  const VerdantCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.borderColor,
    this.glow = false,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color? borderColor;
  final bool glow;

  @override
  Widget build(BuildContext context) {
    final b = borderColor ?? kBorderSubtle;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: kSurfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: b,
          width: glow ? 1.8 : 1,
        ),
        boxShadow: glow
            ? [
                BoxShadow(
                  color: kPrimaryGreen.withValues(alpha: 0.15),
                  blurRadius: 24,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
