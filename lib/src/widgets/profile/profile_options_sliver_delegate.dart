import 'package:flutter/material.dart';

class ProfileOptionsSliverDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;

  ProfileOptionsSliverDelegate(this.tabController);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 0, color: Colors.transparent),
          boxShadow: null,
        ),
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          controller: tabController,
          labelColor: Colors.grey.shade50,
          indicatorColor: Colors.transparent,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            shape: BoxShape.rectangle,
            color: Theme.of(context).colorScheme.secondary,
          ),
          splashBorderRadius: BorderRadius.circular(8),
          tabs: const [
            Tab(text: "Moments"),
            Tab(text: "Places"),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 64;

  @override
  double get minExtent => 64;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      this != oldDelegate;
}
