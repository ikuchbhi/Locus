import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final Widget textFormField;

  const CustomTextFormField(
    this.label,
    this.textFormField, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          textFormField,
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
