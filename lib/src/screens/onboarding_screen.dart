import 'package:flutter/material.dart';

import 'sign_up_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late AnimationController fadeAnimation;
  late AnimationController opacityAnimation;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    opacityAnimation = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
    )..forward();
    fadeAnimation = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 450,
      ),
    )..forward();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  FadeTransition(
                    opacity: opacityAnimation,
                    child: Image.asset(
                      'assets/images/login-bg.jpg',
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.darken,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  Positioned(
                    top: height * 0.35 + 10,
                    left: 18,
                    right: 18,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Locus",
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                fontFamily: 'Aleo',
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Connect and share",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontFamily: 'Aleo',
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                        ),
                        SizedBox(height: height * 0.35),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.resolveWith(
                                (_) => RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                (_) => Theme.of(context).primaryColor,
                              ),
                              foregroundColor:
                                  MaterialStateProperty.resolveWith(
                                (_) => Colors.grey.shade50,
                              ),
                              textStyle: MaterialStateProperty.resolveWith(
                                (_) => const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Aleo',
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                ModalBottomSheetRoute(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25),
                                    ),
                                  ),
                                  builder: (_) => const SignUpScreen(),
                                  isScrollControlled: true,
                                  backgroundColor: Theme.of(context)
                                      .primaryColor
                                      .withAlpha(175),
                                  enableDrag: true,
                                  useSafeArea: true,
                                ),
                              );
                            },
                            child: const Text("Sign Up"),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.resolveWith(
                                (_) => RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                (_) => Theme.of(context).colorScheme.secondary,
                              ),
                              foregroundColor:
                                  MaterialStateProperty.resolveWith(
                                (_) => Colors.grey.shade50,
                              ),
                              textStyle: MaterialStateProperty.resolveWith(
                                (_) => const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Aleo',
                                ),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text("Login"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
