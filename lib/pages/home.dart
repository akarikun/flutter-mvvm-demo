import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../vm/home.dart';
import '../widgets/confirm.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final homeVM = context.watch<HomeViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () async {
              if (await showConfirmDialog(
                context,
                '退出登录',
                '确定要退出当前账号吗？',
                '取消',
                '退出',
              )) {
                homeVM.logout();
              }
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(child: Text(widget.title)),
    );
  }
}
