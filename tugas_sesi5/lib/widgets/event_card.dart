import 'package:flutter/material.dart';

import '../models/event_item.dart';
import '../screens/event_registration_screen.dart';

class EventCard extends StatelessWidget {
  final EventItem event;
  final VoidCallback onRefresh;

  const EventCard({super.key, required this.event, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        // Memenuhi syarat Interaktif (InkWell)
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventRegistrationScreen(event: event),
            ),
          );
          onRefresh(); // Refresh tiket setelah mendaftar
        },
        child: ListTile(
          leading: Image.network(
            event.imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text(event.title),
          subtitle: Text(event.category),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ),
    );
  }
}
