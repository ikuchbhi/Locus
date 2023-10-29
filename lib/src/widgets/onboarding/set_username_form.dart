import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/auth/auth.dart';
import '../../screens/home_page.dart';
import '../util/custom_text_form_field.dart';
import '../util/loading_dialog.dart';
import 'username_checker_field.dart';

class SetUsernameForm extends StatefulWidget {
  final TextEditingController emailController;

  const SetUsernameForm(
    this.emailController, {
    super.key,
  });

  @override
  State<SetUsernameForm> createState() => _SetUsernameFormState();
}

class _SetUsernameFormState extends State<SetUsernameForm> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController usernameController;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    usernameController = TextEditingController();
    nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit(
      context.read(),
      context.read(),
    );
    return BlocListener<AuthCubit, AuthState>(
      bloc: authCubit,
      listener: (c, s) {
        if (s is LoadingAuthState) {
          showLoadingDialog(c);
        } else if (s is LoadedAuthState) {
          Navigator.pop(c);
          Navigator.pushAndRemoveUntil(
            c,
            MaterialPageRoute(
              builder: (_) => MyHomePage(s.user!),
            ),
            (_) => false,
          );
        } else if (s is ErrorAuthState) {
          Navigator.pop(c);
          showErrorDialog(c, s.error);
        }
      },
      child: SingleChildScrollView(
        primary: true,
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Set Username and Name",
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                    color: Colors.grey.shade800,
                  ),
            ),
            const SizedBox(height: 24),
            Text(
              "Enter a username (and optionally set your name) to sign in",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  UsernameCheckerField(usernameController),
                  CustomTextFormField(
                    "Name",
                    TextFormField(
                      controller: nameController,
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
                ],
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
                    (_) => Theme.of(context).colorScheme.secondary,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await authCubit.updateUsernameAndName(
                      widget.emailController.text,
                      usernameController.text,
                      nameController.text,
                    );
                  }
                },
                child: Text(
                  "Set Username and Name",
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
