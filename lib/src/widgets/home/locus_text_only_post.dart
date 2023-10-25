import 'package:flutter/material.dart';

import '../util/text_only_post_content.dart';
import 'locus_post.dart';

class LocusTextOnlyPost extends LocusPost {
  final String text;

  LocusTextOnlyPost({
    super.key,
    required BuildContext context,
    required this.text,
  }) : super(children: [TextOnlyPostContent(text)]);
}
