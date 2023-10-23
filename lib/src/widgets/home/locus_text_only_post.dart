import 'package:flutter/material.dart';

import 'locus_post.dart';

class LocusTextOnlyPost extends LocusPost {
  final String text;

  LocusTextOnlyPost({
    super.key,
    required BuildContext context,
    required this.text,
  }) : super(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(
                  left: BorderSide(
                    color: Color.lerp(
                      Theme.of(context).colorScheme.secondary.withAlpha(100),
                      Theme.of(context).colorScheme.tertiary.withAlpha(100),
                      0.420,
                    )!,
                    width: 4,
                  ),
                ),
              ),
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.only(
                left: 8,
                top: 4,
                bottom: 4,
                right: 4,
              ),
              child: RichText(
                text: TextSpan(
                  text: text,
                  style: TextStyle(
                    color: Colors.grey.shade50,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w200,
                    fontSize: 16,
                  ),
                ),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 5,
              ),
            ),
          ],
        );
}
