import 'package:flutter/material.dart';

import '../widgets/moment/comment_modal.dart';
import '../widgets/util/text_only_post_content.dart';

class MomentScreen extends StatefulWidget {
  const MomentScreen({super.key});

  @override
  State<MomentScreen> createState() => _MomentScreenState();
}

class _MomentScreenState extends State<MomentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Moment"),
      ),
      body: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Colors.grey.shade50,
                        ),
                      ),
                    ),
                    child: const ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://picsum.photos/400",
                        ),
                      ),
                      title: Text("aman_r posted"),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Colors.grey.shade50,
                        ),
                      ),
                    ),
                    child: TextOnlyPostContent(
                      "texttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttexttext",
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(width: 1, color: Colors.grey.shade50),
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.person_pin),
                      title: Text("Juhu Beach, Mumbai"),
                    ),
                  ),
                  ListTile(
                    leading: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.thumb_up_alt_outlined),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.forum_outlined),
                          onPressed: () => showModalBottomSheet(
                            context: context,
                            builder: (c) => Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: const CommentModal(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Google Map
          Placeholder(),
        ],
      ),
    );
  }
}
