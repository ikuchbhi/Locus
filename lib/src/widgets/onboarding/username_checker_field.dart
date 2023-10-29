import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/auth/auth_cubit.dart';
import '../util/custom_text_form_field.dart';

class UsernameCheckerField extends StatefulWidget {
  final TextEditingController usernameController;

  const UsernameCheckerField(
    this.usernameController, {
    super.key,
  });

  @override
  State<UsernameCheckerField> createState() => _UsernameCheckerFieldState();
}

class _UsernameCheckerFieldState extends State<UsernameCheckerField> {
  late bool usernameExists;

  @override
  void initState() {
    super.initState();
    usernameExists = false;
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit(context.read(), context.read());
    return CustomTextFormField(
      "Username",
      TextFormField(
        onChanged: (v) async {
          usernameExists = await authCubit.checkIfUsernameExists(v);
          setState(() {});
        },
        controller: widget.usernameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade600,
              width: 2.0,
            ),
          ),
          helperStyle: const TextStyle(color: Colors.green),
          errorText: _getErrorText(widget.usernameController, usernameExists),
          helperText: _getHelperText(widget.usernameController, usernameExists),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade600,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  String? _getHelperText(
    TextEditingController usernameController,
    bool? usernameExists,
  ) {
    if (usernameExists != null) {
      if (usernameController.text.isEmpty) {
        return null;
      } else if (usernameExists && usernameController.text.isNotEmpty) {
        return null;
      } else if (!usernameExists && usernameController.text.isNotEmpty) {
        return "This is a valid username";
      }
    }
    return null;
  }

  String? _getErrorText(
    TextEditingController usernameController,
    bool? usernameExists,
  ) {
    if (usernameExists != null) {
      if (usernameController.text.isEmpty) {
        return "Please enter a username";
      } else if (usernameExists && usernameController.text.isNotEmpty) {
        return "That username is already taken";
      } else if (!usernameExists && usernameController.text.isNotEmpty) {
        return null;
      }
    }
    return "Please enter a username";
  }
}
