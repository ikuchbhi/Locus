// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/auth/auth_cubit.dart';
import '../models/locus_user.dart';
import '../widgets/home/locus_image_only_post.dart';
import '../widgets/home/locus_image_with_caption_post.dart';
import '../widgets/home/locus_post.dart';
import '../widgets/home/locus_text_only_post.dart';
import 'add_moment_screen.dart';
import 'onboarding_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';
import 'settings_screen.dart';

class MyHomePage extends StatefulWidget {
  final LocusUser user;
  const MyHomePage(this.user, {super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<LocusPost> posts = [];

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit(context.read(), context.read());
    posts = [
      ...List.generate(
        5,
        (i) => LocusImageOnlyPost(
          context: context,
          url: "https://picsum.photos/id/${10 * i}/300/",
        ),
      ),
      ...List.generate(
        5,
        (i) => LocusTextOnlyPost(
          context: context,
          text:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur placerat est id nisi volutpat pulvinar. Nulla facilisi. Integer facilisis, dolor non tempus dictum, magna dui maximus tortor, ut pharetra tellus dui at odio. Donec lacus odio, dapibus id velit nec, scelerisque commodo enim. Proin pharetra, lacus nec lobortis tincidunt, lorem neque venenatis nulla, vel volutpat arcu dolor nec magna. Donec sollicitudin efficitur massa. Pellentesque nec ligula eu urna luctus mattis. Nulla non nisi arcu. Sed rutrum turpis id mauris faucibus, vel ornare ante congue. Sed elit magna, maximus vitae consequat vitae, vestibulum sit amet sapien.",
        ),
      ),
      ...List.generate(
        5,
        (i) => LocusImageWithCaptionPost(
          context: context,
          url: "https://picsum.photos/id/${10 * i}/300/",
          caption:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur placerat est id nisi volutpat pulvinar. Nulla facilisi.",
        ),
      ),
    ];

    final query = ModalRoute.of(context) != null
        ? (ModalRoute.of(context)!.settings.arguments != null
            ? ModalRoute.of(context)!.settings.arguments as String
            : "")
        : "";
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
                query: query,
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
          PopupMenuButton(
            itemBuilder: (c) => [
              PopupMenuItem(
                child: const ListTile(
                  leading: Icon(Icons.person_pin_circle_rounded),
                  title: Text("Profile"),
                ),
                onTap: () => Navigator.push(
                  c,
                  MaterialPageRoute(
                    builder: (_) => const ProfileScreen(),
                  ),
                ),
              ),
              PopupMenuItem(
                child: const ListTile(
                  leading: Icon(Icons.settings),
                  title: Text("Settings"),
                ),
                onTap: () => Navigator.push(
                  c,
                  MaterialPageRoute(
                    builder: (_) => SettingsScreen(widget.user.emailAddress),
                  ),
                ),
              ),
              PopupMenuItem(
                child: const ListTile(
                  leading: Icon(Icons.logout_rounded),
                  title: Text("Logout"),
                ),
                onTap: () async {
                  await authCubit.logOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const OnboardingScreen(),
                    ),
                    (_) => false,
                  );
                },
              ),
            ],
            icon: const Icon(Icons.more_vert_rounded),
            tooltip: "More Options",
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500));
          setState(() {});
        },
        backgroundColor: Colors.grey.shade50,
        color: Theme.of(context).colorScheme.secondary,
        child: Column(
          children: [
            const ListTile(
              title: Text(
                "Hello, User!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "You have new posts!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: (c, i) => posts[i],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a, sa) => const AddMomentScreen(),
            transitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (c, a, sa, child) {
              final offset = Tween<Offset>(
                end: Offset.zero,
                begin: const Offset(0, 1.0),
              ).chain(CurveTween(curve: Curves.easeInOut));

              return SlideTransition(
                position: a.drive(offset),
                child: child,
              );
            },
            fullscreenDialog: true,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        enableFeedback: true,
        tooltip: "Add Moment",
        child: const Icon(Icons.add),
      ),
    );
  }
}
