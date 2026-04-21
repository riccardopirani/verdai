import 'package:flutter/foundation.dart';

import '../../core/constants/app_constants.dart';
import '../../services/supabase_service.dart';

/// Notifies [GoRouter] when Supabase auth state changes.
class AuthRefreshNotifier extends ChangeNotifier {
  AuthRefreshNotifier() {
    if (AppConstants.isSupabaseConfigured) {
      SupabaseService.instance.authStateChanges.listen((_) {
        notifyListeners();
      });
    }
  }
}
