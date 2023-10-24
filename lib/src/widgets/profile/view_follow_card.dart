import 'package:flutter/material.dart';

import '../../screens/profile_screen.dart';

class ViewFollowCard extends StatelessWidget {
  final String val;

  const ViewFollowCard(this.val, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: NetworkImage("https://picsum.photos/200"),
        ),
        title: Text(val),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward_ios_rounded),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => ProfileScreen(),
            ),
          ),
        ),
      ),
    );
  }
}
