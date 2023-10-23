import 'package:flutter/material.dart';

import '../widgets/search/search_location.dart';
import '../widgets/search/search_user_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late bool usernameVal;
  late bool nameVal;
  late bool locationVal;
  late List<Widget> items1, items2;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    items1 = List<Widget>.generate(10, (i) => const SearchUserTile());
    items2 = List<Widget>.generate(5, (i) => const SearchLocationTile());
    usernameVal = false;
    nameVal = false;
    locationVal = false;
    tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: const Duration(milliseconds: 250),
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kBottomNavigationBarHeight * 2),
        child: AppBar(
          title: const Text("Search"),
          backgroundColor: Theme.of(context).primaryColor,
          // shape: const RoundedRectangleBorder(
          //   borderRadius: BorderRadius.horizontal(
          //     right: Radius.circular(15),
          //   ),
          // ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight * 1.2),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(
                onTap: () => showSearch(
                  context: context,
                  delegate: LocusSearchDelegate(),
                ),
                side: MaterialStateProperty.resolveWith(
                  (_) => BorderSide(width: 2, color: Colors.grey.shade600),
                ),
                shape: MaterialStateProperty.resolveWith(
                  (_) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                hintText: "Search for users/locations...",
                backgroundColor: MaterialStateProperty.resolveWith(
                  (_) => Colors.grey.shade50,
                ),
                textStyle: MaterialStateProperty.resolveWith(
                  (_) => TextStyle(
                    color: Colors.grey.shade900,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(15),
              ),
            ),
            child: TabBar(
              controller: tabController,
              indicator: const BoxDecoration(borderRadius: BorderRadius.zero),
              indicatorColor: Theme.of(context).colorScheme.secondary,
              labelColor: Theme.of(context).colorScheme.secondary,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Aleo',
              ),
              tabs: const [
                Tab(text: "Users"),
                Tab(text: "Locations"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (c, i) => items1[i],
                  itemCount: items1.length,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (c, i) => items2[i],
                  itemCount: items2.length,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LocusSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () => query = "",
          icon: const Icon(Icons.close),
        ),
        IconButton(
          icon: const Icon(Icons.tune_rounded),
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (c) => SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 8.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Text(
                    "Filter By:",
                    style: Theme.of(c).textTheme.titleLarge!.apply(
                          color: Colors.grey.shade50,
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        CheckboxMenuButton(
                          value: false,
                          onChanged: (v) {}, //setState(() => usernameVal = v!),
                          child: const Text("User"),
                        ),
                        CheckboxMenuButton(
                          value: false,
                          onChanged: (v) {}, //setState(() => locationVal = v!),
                          child: const Text("Location"),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.filter_list_rounded),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.resolveWith(
                              (_) => RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            foregroundColor: MaterialStateColor.resolveWith(
                              (_) => Colors.grey.shade50,
                            ),
                            backgroundColor: MaterialStateColor.resolveWith(
                              (_) => Theme.of(c).colorScheme.secondary,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(c);
                          },
                          label: Text(
                            "Filter",
                            style: TextStyle(
                              color: Colors.grey.shade50,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ];

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context).copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          titleSpacing: 0,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          fillColor: Theme.of(context).colorScheme.tertiary,
          filled: true,
          // TODO: Find a way to make search text be Colors.grey.shade50, can't seem to at the moment
        ),
        searchBarTheme: SearchBarThemeData(
          backgroundColor: MaterialStateProperty.resolveWith(
            (_) => Colors.grey.shade50,
          ),
          shape: MaterialStateProperty.resolveWith(
            (_) => RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade600, width: 2),
            ),
          ),
        ),
        searchViewTheme: SearchViewThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: Colors.grey.shade600, width: 2),
          ),
          side: BorderSide(color: Colors.grey.shade600, width: 2),
        ),
      );

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => Navigator.pop(context, query),
        icon: const Icon(Icons.arrow_back_outlined),
      );

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (c, i) => ListTile(
        title: Text("Result $i"),
        onTap: () => close(context, "Result $i"),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (c, i) => ListTile(
        title: Text("Suggestion $i"),
        onTap: () => query = "Suggestion $i",
      ),
    );
  }
}
