import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/theme/theme_cubit.dart';
import '../../screens/home_page.dart';
import '../util/custom_text_form_field.dart';

class SetUsernameForm extends StatefulWidget {
  const SetUsernameForm({super.key});

  @override
  State<SetUsernameForm> createState() => _SetUsernameFormState();
}

class _SetUsernameFormState extends State<SetUsernameForm> {
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                CustomTextFormField(
                  "Username",
                  TextFormField(
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
                CustomTextFormField(
                  "Name",
                  TextFormField(
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
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (c) => c.read<ThemeCubit>(),
                      child: const MyHomePage(),
                    ),
                  ),
                  (_) => false,
                );
              },
              child: Text(
                "Set Username and Name",
                style: TextStyle(color: Colors.grey.shade50, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
