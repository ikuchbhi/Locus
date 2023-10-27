import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/onboarding/set_username_form.dart';
import '../widgets/onboarding/sign_up_form.dart';
import '../widgets/onboarding/verify_email_with_token_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  late StreamController<bool> _tnc;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late AnimationController _swipeAnimController;
  late StreamController<int> _currentPage;
  late List<Widget> pages;

  static const _viewportFraction = 0.67;

  @override
  void initState() {
    super.initState();
    _currentPage = StreamController.broadcast();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _tnc = StreamController.broadcast();
    _swipeAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _tnc.sink.add(false);
    _currentPage.sink.add(0);
    pages = [
      SignUpForm(
        _currentPage,
        _emailController,
        _passwordController,
        _tnc,
      ),
      VerifyEmailWithTokenForm(_currentPage, _emailController),
      SetUsernameForm(_emailController),
    ];
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _tnc.close();
    _currentPage.close();
    _swipeAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
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
      body: Center(
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
              child: StreamBuilder<int>(
                  stream: _currentPage.stream,
                  builder: (c, s) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 750),
                      switchInCurve: Curves.elasticOut,
                      switchOutCurve: Curves.elasticIn,
                      child: AnimatedCrossFade(
                        firstCurve: Curves.elasticIn,
                        secondCurve: Curves.elasticOut,
                        crossFadeState: CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 750),
                        firstChild: pages[s.hasData ? s.data! : 0],
                        secondChild: pages[s.hasData ? s.data! : 0],
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
