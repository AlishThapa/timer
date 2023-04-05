import 'package:flutter/material.dart';
import 'package:untitled2/countdown_page.dart';

import 'ccc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Countdown',
      home: MyHomePage(),
    );
  }
}

