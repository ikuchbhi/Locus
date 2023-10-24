import 'package:flutter/material.dart';

import '../widgets/profile/view_follow_card.dart';

class ViewFollowScreen extends StatefulWidget {
  final String title;
  const ViewFollowScreen(this.title, {super.key});

  @override
  State<ViewFollowScreen> createState() => _ViewFollowScreenState();
}

class _ViewFollowScreenState extends State<ViewFollowScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: List.generate(
          10,
          (index) => ViewFollowCard(index.toString()),
        ),
      ),
    );
  }
}
