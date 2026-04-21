import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/constants/app_constants.dart';
import '../../services/supabase_service.dart';

final authSessionProvider = StreamProvider<Session?>((ref) {
  if (!AppConstants.isSupabaseConfigured) {
    return Stream.value(null);
  }
  return SupabaseService.instance.authStateChanges.map((event) => event.session);
});

final currentUserProvider = Provider<User?>((ref) {
  final async = ref.watch(authSessionProvider);
  return async.maybeWhen(data: (s) => s?.user, orElse: () => null);
});

final companyIdProvider = FutureProvider<String?>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;
  final c = await SupabaseService.instance.fetchCompanyForUser(user.id);
  return c?.id;
});
