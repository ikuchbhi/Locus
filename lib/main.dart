import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // Get all environment variables
  await dotenv.load();

  // Makes sure Flutter is initialised properly
  WidgetsFlutterBinding.ensureInitialized();

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Aleo',
        primaryColor: Color(0xFFFB8B24),
        colorScheme:
            ThemeData(brightness: Brightness.dark).colorScheme.copyWith(
                  // brightness: Brightness.dark,
                  secondary: Color(0xC40208FC),
                  tertiary: Color(0x40DADFF7),
                  error: Color(0xFFBB342F),
                  //success: Color(0xFF48BB78),
                ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
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
      backgroundColor: Theme.of(context).colorScheme.tertiary,
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
