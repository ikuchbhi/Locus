import 'dart:async';

import 'package:flutter/material.dart';

import '../util/custom_password_field.dart';
import '../util/custom_text_form_field.dart';
import 'google_sign_in_button.dart';
import 'tnc.dart';

class SignUpForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final StreamController<bool> tnc;
  final StreamController<int> currentPage;

  const SignUpForm(
    this.currentPage,
    this.emailController,
    this.passwordController,
    this.tnc, {
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      primary: true,
      child: Column(
        children: [
          Text(
            "Sign Up",
            style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: Colors.grey.shade800,
                ),
            textAlign: TextAlign.center,
          ),
          CustomTextFormField(
            "Email ID",
            TextFormField(
              controller: widget.emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                    width: 2.0,
                  ),
                ),
              ),
            ),
          ),
          CustomPasswordField(widget.passwordController),
          TermsAndConditionsField(widget.tnc),
          const SizedBox(height: 8),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.resolveWith(
                  (_) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                foregroundColor: MaterialStateColor.resolveWith(
                  (_) => Colors.grey.shade50,
                ),
                backgroundColor: MaterialStateColor.resolveWith(
                  (_) => Theme.of(context).colorScheme.secondary,
                ),
              ),
              onPressed: () {
                widget.currentPage.sink.add(1);
              },
              child: Text(
                "Sign Up",
                style: TextStyle(color: Colors.grey.shade50, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Divider(color: Colors.black, indent: 24, endIndent: 24),
          const SizedBox(height: 6),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const GoogleSignInButton(),
          ),
        ],
      ),
    );
  }
}
