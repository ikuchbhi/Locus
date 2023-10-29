import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/auth/auth.dart';
import '../util/custom_password_field.dart';
import '../util/custom_text_form_field.dart';
import '../util/loading_dialog.dart';
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
  late GlobalKey<FormState> _key;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit(
      context.read(),
      context.read(),
    );

    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      primary: true,
      child: BlocListener<AuthCubit, AuthState>(
        bloc: authCubit,
        listener: (c, s) {
          if (s is LoadingAuthState) {
            showLoadingDialog(c);
          } else if (s is ErrorAuthState) {
            Navigator.pop(c);
            showErrorDialog(c, s.error);
          } else if(s is LoadedAuthState) {
            Navigator.pop(c);
            widget.currentPage.sink.add(1);
          }
        },
        child: Form(
          key: _key,
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
                  validator: (v) {
                    if (v != null && v.trim().isNotEmpty) {
                      if (!RegExp(r'^[a-zA-Z0-9_.]+@[a-zA-Z0-9.-]+$')
                          .hasMatch(v)) {
                        return "Please enter a valid Email ID";
                      }
                    }
                    return null;
                  },
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
              StreamBuilder<bool>(
                stream: widget.tnc.stream,
                builder: (c, s) => SizedBox(
                  width: MediaQuery.of(c).size.width,
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
                            ? Theme.of(c).colorScheme.tertiary.withAlpha(255)
                            : Theme.of(c).colorScheme.secondary,
                      ),
                    ),
                    onPressed: (s.data ?? false)
                        ? () async {
                            if (_key.currentState!.validate()) {
                              _key.currentState!.save();
                              await authCubit.signUp(
                                widget.emailController.text,
                                widget.passwordController.text,
                              );
                            }
                          }
                        : null,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.grey.shade50,
                        fontSize: 16,
                      ),
                    ),
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
        ),
      ),
    );
  }
}
