import '../models/event_item.dart';
import '../models/registration_ticket.dart';

// Data dummy seminar
final List<EventItem> sampleEvents = [
  EventItem(id: '1', title: 'Masa Depan AI', category: 'AI', imageUrl: 'https://picsum.photos/200/300?random=1'),
  EventItem(id: '2', title: 'Flutter untuk Pemula', category: 'Mobile', imageUrl: 'https://picsum.photos/200/300?random=2'),
  EventItem(id: '3', title: 'Smart Home IoT', category: 'IoT', imageUrl: 'https://picsum.photos/200/300?random=3'),
  EventItem(id: '4', title: 'Keamanan Data 2026', category: 'Cybersecurity', imageUrl: 'https://picsum.photos/200/300?random=4'),
];

// Simulasi database tiket terdaftar (agar bisa diakses dari berbagai screen)
List<RegistrationTicket> registeredTickets = [];