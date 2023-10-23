import 'package:flutter/material.dart';

class SearchUserTile extends StatelessWidget {
  const SearchUserTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: const EdgeInsets.all(4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:
              Image.network("https://picsum.photos/200?blur=2").image,
        ),
        title: const Text(
          "Username",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: const Text(
          "User Name",
          style: TextStyle(
            fontWeight: FontWeight.w200,
          ),
        ),
      ),
    );
  }
}
