import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(NusaInfoApp());
}

class NusaInfoApp extends StatelessWidget {
  const NusaInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NusaInfo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
