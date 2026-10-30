import 'package:flutter/material.dart';

import '../models/event_item.dart';
import '../models/registration_ticket.dart';
import '../data/sample_events.dart';

class EventRegistrationScreen extends StatefulWidget {
  final EventItem event;

  const EventRegistrationScreen({super.key, required this.event});

  @override
  State<EventRegistrationScreen> createState() =>
      _EventRegistrationScreenState();
}

class _EventRegistrationScreenState extends State<EventRegistrationScreen> {
  final _formKey = GlobalKey<FormState>(); // Memenuhi syarat GlobalKey

  final _nameController = TextEditingController();
  final _nimController = TextEditingController();
  final _emailController = TextEditingController();
  final _waController = TextEditingController();

  DateTime? _selectedDate;
  bool _isLoading = false;
  bool _agreeToRules = false;

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      // Memenuhi syarat showDatePicker()
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _agreeToRules) {
      setState(() {
        _isLoading = true; // Indikator loading
      });

      // Simulasi proses delay jaringan
      await Future.delayed(const Duration(seconds: 2));

      // Simpan tiket
      final ticket = RegistrationTicket(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        eventName: widget.event.title,
        participantName: _nameController.text,
        nim: _nimController.text,
        attendanceDate:
            "${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}",
      );
      registeredTickets.add(ticket);

      setState(() {
        _isLoading = false;
      });

      if (!mounted) return;

      // Memenuhi syarat SnackBar
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Pendaftaran Berhasil!')));

      Navigator.pop(context);
    } else if (_selectedDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Pilih tanggal kehadiran!')));
    } else if (!_agreeToRules) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Setujui tata tertib!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar ${widget.event.title}')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Lengkap',
                      ),
                      validator: (v) =>
                          v!.isEmpty ? 'Tidak boleh kosong' : null,
                    ),
                    TextFormField(
                      controller: _nimController,
                      decoration: const InputDecoration(labelText: 'NIM'),
                      validator: (v) =>
                          v!.isEmpty ? 'Tidak boleh kosong' : null,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) =>
                          v!.contains('@') ? null : 'Email tidak valid',
                    ),
                    TextFormField(
                      controller: _waController,
                      decoration: const InputDecoration(
                        labelText: 'No WhatsApp',
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (v) =>
                          v!.isEmpty ? 'Tidak boleh kosong' : null,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedDate == null
                                ? 'Belum pilih tanggal'
                                : 'Tanggal: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _pickDate,
                          child: const Text('Pilih Tanggal'),
                        ),
                      ],
                    ),
                    CheckboxListTile(
                      title: const Text('Saya menyetujui tata tertib seminar'),
                      value: _agreeToRules,
                      onChanged: (val) {
                        setState(() {
                          _agreeToRules = val!;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: const Text('Daftar Sekarang'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
