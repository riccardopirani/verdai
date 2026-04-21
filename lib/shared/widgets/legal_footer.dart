import 'package:flutter/material.dart';

class LegalFooter extends StatelessWidget {
  const LegalFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Colors.black,
          fontSize: 15,
          height: 1.55,
          fontWeight: FontWeight.w600,
        );

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          child: Text(
            'Marconi Software S.R.L - Via del Riccio 24/A, Dodici Morelli (FE) - VAT IT02190840385',
            textAlign: TextAlign.center,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}

