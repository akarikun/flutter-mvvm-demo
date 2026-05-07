import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../pages/home.dart';
import '../services/auth.dart';
import '../vm/home.dart';
import '../pages/login.dart';
import '../vm/auth.dart';
import '../vm/login.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();

    return StreamBuilder<AuthState>(
      stream: authVM.authStateChanges,
      builder: (context, snapshot) {
        final session = snapshot.data?.session ?? authVM.currentSession;

        // 未登录
        if (session == null) {
          return ChangeNotifierProvider(
            create: (_) =>
                LoginViewModel(AuthService(Supabase.instance.client)),
            child: const LoginPage(),
          );
        }

        return ChangeNotifierProvider(
          create: (_) => HomeViewModel(),
          child: const HomePage(title: 'Flutter MVVM Demo'),
        );
      },
    );
  }
}
