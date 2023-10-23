import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../controllers/theme/theme_cubit.dart';
import 'search_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: () async {
              final q = await showSearch(
                context: context,
                delegate: LocusSearchDelegate(),
              );
              if (q != null) {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    settings: RouteSettings(arguments: q),
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: const SearchScreen(),
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 750),
                    transitionsBuilder: (context, a1, a2, child) {
                      final offsetTween = Tween<Offset>(
                        begin: const Offset(0.8, 0),
                        end: const Offset(0, 0),
                      ).chain(
                        CurveTween(
                          curve: Curves.easeInOut,
                        ),
                      );
                      final anim = a1.drive(offsetTween);
                      return SlideTransition(
                        position: anim,
                        child: child,
                      );
                    },
                  ),
                );
              }
            },
            icon: const Icon(Icons.search_rounded),
            tooltip: 'Search',
          ),
        ],
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          fit: StackFit.expand,
          children: [
            Column(
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
          ],
        ),
      ),
    );
  }
}
