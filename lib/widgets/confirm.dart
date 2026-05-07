import 'package:flutter/material.dart';

Future<bool> showConfirmDialog(
  BuildContext context,
  String title,
  String content,
  String cancelText,
  String confirmText,
) async {
  final shouldLogout = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      );
    },
  );

  return shouldLogout == true;
}
