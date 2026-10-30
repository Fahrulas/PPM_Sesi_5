import 'package:flutter/material.dart';

class VenueMapViewer extends StatelessWidget {
  const VenueMapViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      color: Colors.grey[200],
      child: InteractiveViewer(
        // Memenuhi syarat InteractiveViewer (Zoom & Pan)
        minScale: 0.5,
        maxScale: 4.0,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.map, size: 80, color: Colors.grey),
              Text('Peta Denah Venue (Bisa di-zoom/geser)'),
            ],
          ),
        ),
      ),
    );
  }
}
