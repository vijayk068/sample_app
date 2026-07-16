import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> items = [
    'Apple',
    'Banana',
    'Mango',
    'Orange',
    'Grapes',
    'Pineapple',
    'Watermelon',
  ];

  final ValueNotifier<String> searchText = ValueNotifier('');
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: searchText,
      builder: (context, value, _) {
        // where() filters the list based on the search text
        final filteredItems = items
            .where((item) => item.toLowerCase().contains(value.toLowerCase()))
            .toList();

        // map() transforms each remaining item into a display label
        final displayItems = filteredItems.map((item) => '• $item').toList();

        return Scaffold(
          appBar: AppBar(title: const Text('Search List'), centerTitle: false),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Search list using map() and where()',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search item',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    searchText.value = value;
                  },
                ),
                const SizedBox(height: 16),
                Text('Results: ${displayItems.length}'),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView(
                    children: displayItems
                        .map((item) => Card(child: ListTile(title: Text(item))))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
