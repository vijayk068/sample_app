import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> with SingleTickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<String> searchText = ValueNotifier('');

  late final TabController tabController;

  final List<String> nameList = ['Ajay', 'Vijay', 'Sanjay', 'Pillu'];

  final List<String> cityList = ['Pune', 'Mumbai', 'Delhi', 'Bengaluru'];

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);

    tabController.addListener(() {
      // Clear search only after tab change completes.
      if (!tabController.indexIsChanging) {
        searchController.clear();
        searchText.value = '';
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    searchController.dispose();
    searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(text: 'Names'),
            Tab(text: 'Cities'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              onChanged: (value) {
                searchText.value = value;
              },
              decoration: const InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: AnimatedBuilder(
                animation: tabController,
                builder: (context, _) {
                  final activeList = tabController.index == 0
                      ? nameList
                      : cityList;

                  return ValueListenableBuilder<String>(
                    valueListenable: searchText,
                    builder: (context, search, _) {
                      final result = [...activeList]
                        ..sort((a, b) => a.compareTo(b));

                      final filtered = result.where((item) {
                        return item.toLowerCase().contains(
                          search.toLowerCase(),
                        );
                      }).toList();

                      if (filtered.isEmpty) {
                        return const Center(
                          child: Text("No matching items found"),
                        );
                      }

                      return ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(title: Text(filtered[index])),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
