// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/auth/auth.dart';
import '../../screens/home_page.dart';
import '../util/custom_password_field.dart';
import '../util/custom_text_form_field.dart';
import '../util/loading_dialog.dart';
import 'google_sign_in_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late final TextEditingController emailUsernameController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> _resetKey;
  late final GlobalKey<FormState> _loginKey;

  static const _viewportFraction = 0.65;

  @override
  void initState() {
    super.initState();
    _resetKey = GlobalKey<FormState>();
    _loginKey = GlobalKey<FormState>();
    emailUsernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailUsernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit(context.read(), context.read());
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15),
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        bloc: authCubit,
        listener: (c, s){
          if(s is LoadingAuthState){
            showLoadingDialog(c);
          } else if (s is SuccessPasswordResetState){
            Navigator.pop(c);
            showSuccessDialog(c, "Password resetted successfully!");
          } else if (s is FailurePasswordResetState){
            Navigator.pop(c);
            showErrorDialog(c, s.error);
          } 
        },
        child: Center(
          child: SizedBox(
            height: _viewportFraction * height,
            child: Card(
              color: Colors.grey.shade50,
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 8.0,
                ),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  primary: true,
                  child: Form(
                    key: _loginKey,
                    child: Column(
                      children: [
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.headlineSmall!.apply(
                                color: Colors.grey.shade800,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        CustomTextFormField(
                          "Email ID/Username",
                          TextFormField(
                            validator: (v) => v == null || v.trim().isEmpty
                                ? "Please enter a valid Email/Username"
                                : null,
                            controller: emailUsernameController,
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
                        CustomPasswordField(passwordController),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              splashColor: Theme.of(context).colorScheme.tertiary,
                              borderRadius: BorderRadius.circular(5),
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              onTap: () async {
                                final ec = TextEditingController();
                                await showDialog(
                                  context: context,
                                  builder: (c) => AlertDialog(
                                    title: const Text("Reset Password"),
                                    content: Form(
                                      key: _resetKey,
                                      child: CustomTextFormField(
                                        "Enter Email ID:",
                                        TextFormField(
                                          controller: ec,
                                          validator: (v) {
                                            if (v != null && v.trim().isNotEmpty) {
                                              if (!RegExp(
                                                r'^[a-zA-Z0-9_.]+@[a-zA-Z0-9.-]+$',
                                              ).hasMatch(v)) {
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
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text("Reset"),
                                        onPressed: () async {
                                          if (_resetKey.currentState!
                                              .validate()) {
                                            _resetKey.currentState!.save();
                                            await authCubit
                                                .sendResetPasswordEmail(ec.text);
                                            Navigator.pop(c);
                                          }
                                        },
                                      ),
                                      TextButton(
                                        child: const Text("Cancel"),
                                        onPressed: () => Navigator.pop(c),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
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
                            onPressed: () async {
                              if (_loginKey.currentState!.validate()) {
                                _loginKey.currentState!.save();
                                final isEmail = RegExp(
                                  r'^[a-zA-Z0-9_.]+@[a-zA-Z0-9.-]+$',
                                ).hasMatch(emailUsernameController.text);
                                if (isEmail) {
                                  await authCubit.loginViaEmail(emailUsernameController.text, passwordController.text);
                                } else {
                                  await authCubit.loginViaUsername(emailUsernameController.text, passwordController.text);
                                }
                                await Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const MyHomePage(),
                                  ),
                                  (_) => false,
                                );
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.grey.shade50,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          indent: 24,
                          endIndent: 24,
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: const GoogleSignInButton(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
