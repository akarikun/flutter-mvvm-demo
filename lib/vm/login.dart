import 'package:flutter/foundation.dart';
import 'package:flweb/services/auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService;
  bool isRegister = false;
  bool obscurePassword = true;
  bool isLoading = false;
  String email = '';
  String password = '';
  String? errorMessage;

  LoginViewModel(this._authService);

  void setRegisterMode(bool value) {
    isRegister = value;
    notifyListeners();
  }

  void toggleMode() {
    isRegister = !isRegister;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  void updateLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void updateErrorMessage(String? message) {
    errorMessage = message;
    notifyListeners();
  }

  Future<void> login() async {
    if (isLoading) return;
    updateLoading(true);
    try {
      final AuthResponse res = await _authService.login(email, password);
      // final Session? session = res.session;
      final User? user = res.user;
      if (user == null) {
        updateErrorMessage('登录失败，请稍后再试');
        return;
      }
    } catch (e) {
      updateErrorMessage('登录失败: $e');
    }
    updateLoading(false);
  }

  Future<void> register() async {
    if (isLoading) return;
    updateLoading(true);
    try {
      final AuthResponse res = await _authService.register(email, password);
      // final Session? session = res.session;
      final User? user = res.user;
      if (user == null) {
        updateErrorMessage('注册失败，请稍后再试');
        return;
      }
    } catch (e) {
      updateErrorMessage('注册失败: $e');
    }
    updateLoading(false);
  }
}
