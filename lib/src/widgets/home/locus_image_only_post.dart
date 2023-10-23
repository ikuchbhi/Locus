import 'package:flutter/material.dart';

import 'locus_post.dart';

class LocusImageOnlyPost extends LocusPost {
  final String url;

  LocusImageOnlyPost({
    super.key,
    required BuildContext context,
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
          ],
        );
}
