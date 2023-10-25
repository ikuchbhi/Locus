import 'package:flutter/material.dart';

import '../../screens/moment_screen.dart';

abstract class LocusPost extends StatelessWidget {
  final List<Widget> children;

  const LocusPost({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                  backgroundImage: Image.network(
                    "https://picsum.photos/200?blur=2",
                  ).image,
                  radius: 18,
                ),
                const SizedBox(width: 12),
                Text(
                  "User posted:",
                  style: TextStyle(
                    color: Colors.grey.shade50,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Center(
              child: SizedBox(
                height: 16,
                width: MediaQuery.of(context).size.width * 0.9,
                child: const Divider(),
              ),
            ),
            ...children,
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: const Divider(),
              ),
            ),
            ListTile(
              dense: true,
              leading: const Icon(Icons.crisis_alert_outlined),
              title: const Text("Location "),
              trailing: IconButton(
                icon: const Icon(Icons.exit_to_app_rounded),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => const MomentScreen(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
