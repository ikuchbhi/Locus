import 'package:flutter/material.dart';

import 'locus_comment.dart';

class CommentModal extends StatelessWidget {
  const CommentModal({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(
      10,
      (i) => LocusComment(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam commodo faucibus urna at ullamcorper. Morbi posuere justo vel turpis sagittis, ut eleifend odio volutpat. Quisque faucibus, felis quis congue aliquet, magna nisl bibendum lectus, et cursus lectus velit id massa. Curabitur odio erat, aliquet sit amet sem vel, tempus vulputate est. Fusce faucibus justo vel blandit porttitor. Sed sollicitudin felis vel velit semper, ac vestibulum lorem condimentum. Curabitur maximus ipsum vitae urna facilisis, et tristique neque accumsan. Nulla auctor quis est ac hendrerit."
      ),
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Comments",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.grey.shade50,
                ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemBuilder: (c, i) => items[i],
            itemCount: items.length,
          ),
        ),
      ],
    );
  }
}
