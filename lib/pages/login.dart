import 'package:flutter/material.dart';
import 'package:flweb/vm/login.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final loginVM = context.watch<LoginViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SegmentedButton<bool>(
                    segments: const [
                      ButtonSegment(value: false, label: Text('登录')),
                      ButtonSegment(value: true, label: Text('注册')),
                    ],
                    selected: {loginVM.isRegister},
                    onSelectionChanged: (selected) {
                      loginVM.setRegisterMode(selected.first);
                    },
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => loginVM.email = value,
                    decoration: const InputDecoration(
                      labelText: '邮箱',
                      hintText: '',
                      prefixIcon: Icon(Icons.mail_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    obscureText: loginVM.obscurePassword,
                    textInputAction: loginVM.isRegister
                        ? TextInputAction.next
                        : TextInputAction.done,
                    onChanged: (value) => loginVM.password = value,
                    decoration: InputDecoration(
                      labelText: '密码',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        tooltip: loginVM.obscurePassword ? '显示密码' : '隐藏密码',
                        onPressed: () {
                          setState(() {
                            loginVM.togglePasswordVisibility();
                          });
                        },
                        icon: Icon(
                          loginVM.obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                  ),
                  if (loginVM.isRegister) ...[
                    const SizedBox(height: 16),
                    TextField(
                      obscureText: loginVM.obscurePassword,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        labelText: '确认密码',
                        prefixIcon: Icon(Icons.lock_reset_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () async {
                      if (loginVM.isRegister) {
                        await loginVM.register();
                      } else {
                        await loginVM.login();
                      }
                    },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: loginVM.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(loginVM.isRegister ? '注册' : '登录'),
                  ),
                  if (loginVM.errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      loginVM.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
