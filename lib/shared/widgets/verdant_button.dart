import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';

class VerdantButton extends StatefulWidget {
  const VerdantButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = VerdantButtonVariant.primary,
    this.icon,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final VerdantButtonVariant variant;
  final IconData? icon;
  final bool expand;

  @override
  State<VerdantButton> createState() => _VerdantButtonState();
}

enum VerdantButtonVariant { primary, ghost }

class _VerdantButtonState extends State<VerdantButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final isPrimary = widget.variant == VerdantButtonVariant.primary;

    Widget child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(widget.icon, size: 20),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Text(
            widget.label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: isPrimary ? kDeepForest : kTextPrimary,
                ),
          ),
        ),
      ],
    );

    if (widget.expand) {
      child = SizedBox(width: double.infinity, child: child);
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedScale(
        scale: _hover ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            gradient: isPrimary ? kPrimaryGradient : null,
            color: isPrimary ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isPrimary
                  ? Colors.transparent
                  : (_hover ? kPrimaryGreen : kBorderSubtle),
              width: 1.5,
            ),
            boxShadow: isPrimary
                ? [
                    BoxShadow(
                      color: kPrimaryGreen.withValues(alpha: 0.35),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: widget.onPressed,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
