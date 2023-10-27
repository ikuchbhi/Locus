import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/auth/auth.dart';
import '../util/custom_text_form_field.dart';

class VerifyEmailWithTokenForm extends StatefulWidget {
  final StreamController<int> currentPage;
  final TextEditingController emailController;

  const VerifyEmailWithTokenForm(
    this.currentPage,
    this.emailController, {
    super.key,
  });

  @override
  State<VerifyEmailWithTokenForm> createState() =>
      _VerifyEmailWithTokenFormState();
}

class _VerifyEmailWithTokenFormState extends State<VerifyEmailWithTokenForm> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _tokenController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _tokenController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit(
      context.read(),
      context.read(),
    );
    return SingleChildScrollView(
      primary: true,
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Verify Email",
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                    color: Colors.grey.shade800,
                  ),
            ),
            const SizedBox(height: 24),
            Text(
              "Enter the token sent to your email ID below",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: CustomTextFormField(
                "One-Time Token",
                TextFormField(
                  validator: (v) {
                    if (v != null && v.trim().isNotEmpty) {
                      if (v.length < 6) {
                        return "Please enter a valid Token";
                      }
                    }
                    return null;
                  },
                  controller: _tokenController,
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
            ),
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
                    (s) => s.contains(MaterialState.disabled)
                        ? Theme.of(context).colorScheme.tertiary.withAlpha(255)
                        : Theme.of(context).colorScheme.secondary,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await authCubit.verifyToken(
                      widget.emailController.text,
                      _tokenController.text,
                    );
                    widget.currentPage.add(2);
                  }
                },
                child: Text(
                  "Verify OTP",
                  style: TextStyle(color: Colors.grey.shade50, fontSize: 16),
                ),
              ),
            ),
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
                    (_) => Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Resend OTP",
                  style: TextStyle(color: Colors.grey.shade50, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
