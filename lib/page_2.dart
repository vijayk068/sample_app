import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> with SingleTickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<String> searchText = ValueNotifier('');

  late final TabController tabController;

  final List<String> nameList = ["Ajay", "Vijay", "Sanjay", "Pillu"];

  final List<String> cityList = ["Pune", "Mumbai", "Delhi", "Bengaluru"];

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);

    tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (tabController.indexIsChanging) return;

    searchController.clear();
    searchText.value = '';
  }

  @override
  void dispose() {
    tabController.removeListener(_onTabChanged);
    tabController.dispose();
    searchController.dispose();
    searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page 2"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TabBar(
              controller: tabController,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(24),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black87,
              labelStyle: const TextStyle(fontWeight: FontWeight.w600),
              tabs: const [
                Tab(text: "Names"),
                Tab(text: "Cities"),
              ],
            ),
          ),
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
                hintText: "Search",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  SearchListWidget(items: nameList, searchNotifier: searchText),
                  SearchListWidget(items: cityList, searchNotifier: searchText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchListWidget extends StatelessWidget {
  final List<String> items;
  final ValueNotifier<String> searchNotifier;

  const SearchListWidget({
    super.key,
    required this.items,
    required this.searchNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: searchNotifier,
      builder: (context, search, child) {
        final filteredItems = [...items]
          ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

        final result = filteredItems.where((item) {
          return item.toLowerCase().contains(search.toLowerCase());
        }).toList();

        if (result.isEmpty) {
          return const Center(
            child: Text(
              "No matching items found",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          itemCount: result.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(title: Text(result[index])),
            );
          },
        );
      },
    );
  }
}
