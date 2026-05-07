import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/auth.dart';

class AuthViewModel extends ChangeNotifier {
  AuthViewModel(this._authService);

  final AuthService _authService;

  Session? get currentSession => _authService.currentSession;

  Stream<AuthState> get authStateChanges => _authService.authStateChanges;
}
