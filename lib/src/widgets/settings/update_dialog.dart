import 'package:flutter/material.dart';

void showUpdateDialog({
  required BuildContext context,
  required String titleText,
  required String initialValue,
  required VoidCallback onSave,
}) =>
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(titleText),
        content: TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: onSave,
            child: const Text("Save"),
          ),
          TextButton(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(c),
          ),
        ],
      ),
    );
