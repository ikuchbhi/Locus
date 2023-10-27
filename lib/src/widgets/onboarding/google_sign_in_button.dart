import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/auth/auth_cubit.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});
  @override

  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return SizedBox(
      // width: MediaQuery.of(context).size.width * 0.5,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith(
            (_) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
            (_) => Colors.grey.shade300,
          ),
          side: MaterialStateProperty.resolveWith<BorderSide>(
            (_) => BorderSide(
              color: Colors.grey.shade500,
              width: 2.0,
            ),
          ),
        ),
        onPressed: () async => await authCubit.loginViaGoogle(),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/google.png'),
                height: 60,
                width: 69,
              ),
              const SizedBox(width: 12),
              Text(
                "Continue with Google",
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
