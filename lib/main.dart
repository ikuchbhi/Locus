import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:locus/src/controllers/theme/theme_cubit.dart';
import 'package:locus/src/models/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'src/controllers/auth/auth.dart';
import 'src/screens/onboarding_screen.dart';
import 'src/services/auth_service.dart';

Future<void> main() async {
  // Get all environment variables
  await dotenv.load();

  // Makes sure Flutter is initialised properly
  WidgetsFlutterBinding.ensureInitialized();

  // Setting up HydratedBloc
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  // Initialise Firebase backend
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  // Run Application
  runApp(
    MultiRepositoryProvider(
      providers: [
        // FlutterSecureStorage
        RepositoryProvider<FlutterSecureStorage>(
            create: (_) => const FlutterSecureStorage()),
        // FlutterAppAuth
        RepositoryProvider<FlutterAppAuth>(
            create: (_) => const FlutterAppAuth()),
        RepositoryProvider<AuthService>(
          create: (c) => AuthServiceImpl(
            Supabase.instance.client,
            dotenv.env['ANDROID_CLIENT_ID']!
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (c) => AuthCubit(c.read(), c.read()),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = ThemeCubit();
    return BlocBuilder<ThemeCubit, LocusTheme>(
      bloc: themeCubit,
      builder: (c, s) => MaterialApp(
        debugShowCheckedModeBanner: false,
        themeAnimationCurve: Curves.easeOutExpo,
        themeAnimationDuration: const Duration(milliseconds: 250),
        title: 'Locus',
        theme: s.theme,
        home: BlocProvider.value(
          value: themeCubit,
          child: const OnboardingScreen(),
        ),
      ),
    );
  }
}
