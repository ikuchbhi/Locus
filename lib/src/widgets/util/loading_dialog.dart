import 'package:flutter/material.dart';

showLoadingDialog(BuildContext c) => showDialog(
      context: c,
      barrierDismissible: false,
      builder: (cc) => const AlertDialog(
        title: Text("Loading"),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        ),
      ),
    );

showErrorDialog(BuildContext c, String error) => showDialog(
      context: c,
      builder: (cc) => AlertDialog(
        title: const Text("An Error Occurred"),
        content: Text(error),
      ),
    );

showSuccessDialog(BuildContext c, String msg) => showDialog(
      context: c,
      builder: (cc) => AlertDialog(
        title: const Text("Success!"),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(cc),
            child: const Text("OK"),
          ),
        ],
      ),
    );
