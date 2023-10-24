import 'package:flutter/material.dart';

import '../widgets/home/locus_image_only_post.dart';
import '../widgets/home/locus_image_with_caption_post.dart';
import '../widgets/home/locus_text_only_post.dart';
import '../widgets/profile/places.dart';
import '../widgets/profile/profile_details.dart';
import '../widgets/profile/profile_options_sliver_delegate.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: const Duration(milliseconds: 450),
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

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
      appBar: AppBar(
        title: const Text("View aman_r"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: ProfileDetails()),
          SliverPersistentHeader(
            floating: true,
            pinned: true,
            delegate: ProfileOptionsSliverDelegate(tabController),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: tabController,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (c, i) => moments[i],
                  itemCount: moments.length,
                ),
                // TODO: Map View
                const ProfilePlaces(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
