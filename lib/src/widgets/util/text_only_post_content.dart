import 'package:flutter/material.dart';

class TextOnlyPostContent extends StatelessWidget {
  final String text;

  const TextOnlyPostContent(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      margin: const EdgeInsets.all(22),
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
            fontSize: 20,
          ),
        ),
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        maxLines: 5,
      ),
    );
  }
}
