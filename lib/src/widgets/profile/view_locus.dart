import 'package:flutter/material.dart';

import '../home/locus_image_only_post.dart';
import '../home/locus_image_with_caption_post.dart';
import '../home/locus_text_only_post.dart';

class ViewLocusScreen extends StatefulWidget {
  const ViewLocusScreen({super.key});

  @override
  State<ViewLocusScreen> createState() => _ViewLocusScreenState();
}

class _ViewLocusScreenState extends State<ViewLocusScreen> {
  @override
  Widget build(BuildContext context) {
    final moments = [
      ...List.generate(
        5,
        (i) => LocusImageOnlyPost(
          context: context,
          url: "https://picsum.photos/id/${10 * i}/300/",
        ),
      ),
      ...List.generate(
        5,
        (i) => LocusTextOnlyPost(
          context: context,
          text:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur placerat est id nisi volutpat pulvinar. Nulla facilisi. Integer facilisis, dolor non tempus dictum, magna dui maximus tortor, ut pharetra tellus dui at odio. Donec lacus odio, dapibus id velit nec, scelerisque commodo enim. Proin pharetra, lacus nec lobortis tincidunt, lorem neque venenatis nulla, vel volutpat arcu dolor nec magna. Donec sollicitudin efficitur massa. Pellentesque nec ligula eu urna luctus mattis. Nulla non nisi arcu. Sed rutrum turpis id mauris faucibus, vel ornare ante congue. Sed elit magna, maximus vitae consequat vitae, vestibulum sit amet sapien.",
        ),
      ),
      ...List.generate(
        5,
        (i) => LocusImageWithCaptionPost(
          context: context,
          url: "https://picsum.photos/id/${10 * i}/300/",
          caption:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur placerat est id nisi volutpat pulvinar. Nulla facilisi.",
        ),
      ),
    ];
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: double.infinity,
              height: 48,
              child: Center(
                child: Text(
                  "View Locus",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.grey.shade50,
                      ),
                ),
              ),
            ),
            ListTile(
              onTap: () => showDateRangePicker(
                useRootNavigator: true,
                context: context,
                firstDate: DateTime.now().subtract(const Duration(days: 5)),
                lastDate: DateTime.now(),
              ),
              leading: const Text("Yesterday"),
              trailing: const Text("Today"),
              title: const Text(
                textAlign: TextAlign.center,
                "to",
              ),
              titleAlignment: ListTileTitleAlignment.center,
            ),
            const Placeholder(),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: moments.length,
                // scrollDirection: Axis.horizontal,
                itemBuilder: (c, i) => moments[i],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewLocusDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // TODO: Add Map
    return const Placeholder();
  }

  @override
  double get maxExtent => 500;

  @override
  double get minExtent => 250;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      this != oldDelegate;
}
