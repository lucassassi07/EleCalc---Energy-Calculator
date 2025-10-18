import 'package:flutter/material.dart';

class DeviceSettingsScreen extends StatefulWidget {
  final String deviceName;
  final String deviceType;
  final double expectedMonthlyUsage;
  final String selectedState;

  const DeviceSettingsScreen({
    super.key,
    required this.deviceName,
    required this.deviceType,
    required this.expectedMonthlyUsage,
    required this.selectedState,
  });

  @override
  State<DeviceSettingsScreen> createState() => _DeviceSettingsScreenState();
}

class _DeviceSettingsScreenState extends State<DeviceSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    double dailyKwh = widget.expectedMonthlyUsage / 30;
    double weeklyKwh = widget.expectedMonthlyUsage / 4;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Device: ${widget.deviceName}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 24),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Daily usage (kWh)',
                labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
              style: TextStyle(color: Colors.black, fontSize: 16),
              controller: TextEditingController(
                text: dailyKwh.toStringAsFixed(2),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Weekly usage (kWh)',
                labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
              ),
              style: TextStyle(color: Colors.black, fontSize: 16),
              controller: TextEditingController(
                text: weeklyKwh.toStringAsFixed(2),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}