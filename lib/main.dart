import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

void main() {
  runApp(const SmartHomeApp());
}

class SmartHomeApp extends StatelessWidget {
  const SmartHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EleCalc',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DashboardScreen(), // Change here
    );
  }
}
