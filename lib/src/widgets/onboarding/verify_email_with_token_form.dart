import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../controllers/auth/auth.dart';

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
  late Timer timer;
  late StreamController<bool> emailVerifiedController;

  @override
  void initState() {
    super.initState();
    emailVerifiedController = StreamController.broadcast()..sink.add(false);
  }

  @override
  void dispose() {
    timer.cancel();
    emailVerifiedController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit(
      context.read(),
      context.read(),
    );
    authCubit.sendVerificationLink();
    timer = Timer.periodic(
      const Duration(seconds: 2),
      (_) async {
        final verifiedVal = await authCubit.checkIfEmailVerified();
        if(emailVerifiedController.isClosed){}
        emailVerifiedController.sink.add(verifiedVal);
      },
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
              "Click on the link sent to your email to verify your profile",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: emailVerifiedController.stream,
              builder: (c, s) => Center(
                child: (s.data ?? false)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle_outline_outlined,
                            color: Colors.green,
                            size: 36,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            "Successfully verified!",
                            style: Theme.of(c)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.w100),
                          ),
                        ],
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder<bool>(
                stream: emailVerifiedController.stream,
                builder: (c, s) {
                  return SizedBox(
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
                          (_) => (s.data ?? false)
                              ? Theme.of(c).colorScheme.secondary
                              : Theme.of(c).primaryColor,
                        ),
                      ),
                      onPressed: () async {
                        if (s.data ?? false) {
                          widget.currentPage.sink.add(2);
                        } else {
                          await authCubit.resendVerificationLink();
                        }
                      },
                      child: Text(
                        (s.data ?? false) ? "Next" : "Resend",
                        style:
                            TextStyle(color: Colors.grey.shade50, fontSize: 16),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
