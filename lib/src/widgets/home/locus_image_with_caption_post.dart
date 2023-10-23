import 'package:flutter/material.dart';

import 'locus_post.dart';

class LocusImageWithCaptionPost extends LocusPost {
  final String url;
  final String caption;

  LocusImageWithCaptionPost({
    super.key,
    required BuildContext context,
    required this.caption,
    required this.url,
  }) : super(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                url,
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    final percent = loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!;
                    return Column(
                      children: [
                        Text(
                          "${(100 * percent).truncate()}%",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.grey.shade50),
                        ),
                        LinearProgressIndicator(
                          value: percent,
                        ),
                      ],
                    );
                  } else {
                    return child;
                  }
                },
              ),
            ),
            // const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0),
              child: RichText(
                text: TextSpan(
                  text: caption,
                  style: TextStyle(
                    color: Colors.grey.shade200,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
}
