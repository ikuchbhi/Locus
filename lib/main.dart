import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:locus/src/controllers/theme/theme_cubit.dart';
import 'package:locus/src/models/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  // Initialise Supabase backend
  await Supabase.initialize(
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    url: dotenv.env['SUPABASE_URL']!,
  );

  // Run Application
  runApp(const MyApp());
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
          child: const MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Locus',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<ThemeCubit>(context).toggleTheme();
            },
            icon: const Icon(Icons.contrast_sharp),
            tooltip: 'Toggle theme',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Locus!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Icon(
              Icons.rocket_launch_sharp,
              color: Colors.red,
              size: 64,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).colorScheme.secondary,
        tooltip: 'Launch',
        child: const Icon(Icons.add),
      ),
    );
  }
}
