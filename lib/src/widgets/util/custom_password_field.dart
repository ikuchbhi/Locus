import 'package:flutter/material.dart';

import 'custom_text_form_field.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController passwordController;

  const CustomPasswordField(
    this.passwordController, {
    super.key,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  late bool isVisible;

  @override
  void initState() {
    super.initState();
    isVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      "Password",
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: widget.passwordController,
          maxLines: 1,
          obscureText: !isVisible,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade800,
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade600,
                width: 2.0,
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isVisible
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
                color: Colors.grey.shade700,
              ),
              onPressed: () => setState(() => isVisible = !isVisible),
            ),
          ),
        ),
      ),
    );
  }
}
