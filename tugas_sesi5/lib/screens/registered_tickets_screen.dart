import 'package:flutter/material.dart';

import '../data/sample_events.dart';

class RegisteredTicketsScreen extends StatefulWidget {
  const RegisteredTicketsScreen({super.key});

  @override
  State<RegisteredTicketsScreen> createState() =>
      _RegisteredTicketsScreenState();
}

class _RegisteredTicketsScreenState extends State<RegisteredTicketsScreen> {
  @override
  Widget build(BuildContext context) {
    if (registeredTickets.isEmpty) {
      return const Center(child: Text('Belum ada tiket terdaftar.'));
    }

    return ListView.builder(
      itemCount: registeredTickets.length,
      itemBuilder: (context, index) {
        final ticket = registeredTickets[index];
        return Dismissible(
          // Memenuhi syarat Dismissible
          key: Key(ticket.id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          confirmDismiss: (direction) async {
            // Memenuhi syarat AlertDialog pembatalan
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Batalkan Tiket"),
                  content: const Text(
                    "Apakah Anda yakin ingin membatalkan tiket ini?",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("Tidak"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("Ya"),
                    ),
                  ],
                );
              },
            );
          },
          onDismissed: (direction) {
            setState(() {
              registeredTickets.removeAt(index);
            });
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Tiket dibatalkan")));
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                ticket.eventName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${ticket.participantName} - ${ticket.nim}\nTanggal: ${ticket.attendanceDate}',
              ),
              isThreeLine: true,
            ),
          ),
        );
      },
    );
  }
}
