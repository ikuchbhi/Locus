import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:locus/src/controllers/theme/theme_cubit.dart';
import 'package:locus/src/models/theme.dart';
import 'package:locus/src/screens/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'src/controllers/auth/auth.dart';
import 'src/screens/onboarding_screen.dart';
import 'src/services/auth_service.dart';
import 'src/services/settings_service.dart';

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
          create: (_) => const FlutterSecureStorage(),
        ),
        RepositoryProvider<AuthService>(
          create: (c) => AuthServiceImpl(
            FirebaseAuth.instance,
            FirebaseFirestore.instance,
          ),
        ),
        RepositoryProvider<SettingsService>(
          create: (c) => SettingsServiceImpl(
            FirebaseFirestore.instance,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (c) => AuthCubit(c.read(), c.read()),
          ),
          BlocProvider<ThemeCubit>(
            create: (c) => ThemeCubit(),
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
    final themeCubit = BlocProvider.of<ThemeCubit>(context);
    final authCubit = AuthCubit(context.read(), context.read());
    return BlocBuilder<ThemeCubit, LocusTheme>(
      bloc: themeCubit,
      builder: (c, s) => MaterialApp(
        debugShowCheckedModeBanner: false,
        themeAnimationCurve: Curves.easeOutExpo,
        themeAnimationDuration: const Duration(milliseconds: 250),
        title: 'Locus',
        theme: s.theme,
        home: BlocBuilder<AuthCubit, AuthState>(
          bloc: authCubit,
          builder: (c, s) {
            if (s is LoadingAuthState) {
              authCubit.checkAuthStatus();
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (s is LoadedAuthState) {
              return s.user == null
                  ? const OnboardingScreen()
                  : MyHomePage(s.user!);
            } else if (s is ErrorAuthState) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Error"),
                ),
                body: Center(
                  child: Text(
                    s.error,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
