import 'package:flutter/material.dart';

class LocusComment extends StatelessWidget {
  final String comment;

  const LocusComment(this.comment, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade50,
            ),
          ),
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage("https://picsum.photos/400"),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "aman_r",
                  style: TextStyle(color: Colors.grey.shade50),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Flexible(
                    child: Text(
                      comment,
                      softWrap: true,
                      style: TextStyle(color: Colors.grey.shade50),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
