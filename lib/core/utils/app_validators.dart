import 'package:verdant/l10n/app_localizations.dart';

class AppValidators {
  static String? email(AppLocalizations l10n, String? value) {
    if (value == null || value.trim().isEmpty) return l10n.validatorEmailRequired;
    final email = value.trim();
    final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
    return ok ? null : l10n.validatorEmailInvalid;
  }

  static String? password(AppLocalizations l10n, String? value) {
    if (value == null || value.isEmpty) return l10n.validatorPasswordRequired;
    if (value.length < 8) return l10n.validatorPasswordShort;
    return null;
  }

  static String? required(AppLocalizations l10n, String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validatorRequiredWithLabel(label);
    }
    return null;
  }
}
