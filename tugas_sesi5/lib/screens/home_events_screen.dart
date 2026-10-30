import 'package:flutter/material.dart';

import '../data/sample_events.dart';
import '../widgets/event_card.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/venue_map_viewer.dart';
import 'registered_tickets_screen.dart';

class HomeEventsScreen extends StatefulWidget {
  const HomeEventsScreen({super.key});

  @override
  State<HomeEventsScreen> createState() => _HomeEventsScreenState();
}

class _HomeEventsScreenState extends State<HomeEventsScreen> {
  String _selectedCategory = 'Semua';

  void _showFilter() {
    showModalBottomSheet(
      context: context,
      builder: (context) => FilterBottomSheet(
        selectedCategory: _selectedCategory,
        onCategorySelected: (cat) {
          setState(() {
            _selectedCategory = cat;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter events
    final filteredEvents = _selectedCategory == 'Semua'
        ? sampleEvents
        : sampleEvents.where((e) => e.category == _selectedCategory).toList();

    return DefaultTabController(
      length: 3, // 3 Tab Utama
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NusaEvent Hub'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Seminar'),
              Tab(text: 'Galeri & Venue'),
              Tab(text: 'Tiket'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: _showFilter,
            ),
          ],
        ),
        body: TabBarView(
          children: [
            // Tab 1: Seminar & Workshop
            ListView.builder(
              // Memenuhi syarat ListView.builder
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                return EventCard(
                  event: filteredEvents[index],
                  onRefresh: () => setState(() {}),
                );
              },
            ),

            // Tab 2: Galeri & Denah Venue
            Column(
              children: [
                const VenueMapViewer(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Galeri',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    // Memenuhi syarat GridView.builder
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Image.network(
                        'https://picsum.photos/200/200?random=${index + 10}',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ],
            ),

            // Tab 3: Tiket Terdaftar
            const RegisteredTicketsScreen(),
          ],
        ),
      ),
    );
  }
}
