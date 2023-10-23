import 'package:flutter/material.dart';

class SearchLocationTile extends StatelessWidget {
  const SearchLocationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(4),
      child: Column(
        children: [
          // Map (for now Image)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "https://i.stack.imgur.com/HILmr.png",
                loadingBuilder: (c, child, loadingProgress) {
                  if (loadingProgress != null) {
                    final percent = loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!;
                    return Column(
                      children: [
                        Text(
                          "${(100 * percent).truncate()}%",
                          style: Theme.of(c)
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
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: const Divider(),
          ),
          ListTile(
            leading: const Icon(Icons.location_on_outlined),
            title: const Text(
              "Place",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
