import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final String deviceName;
  final String deviceType;
  final Function(double? power, double? hours) onSave;

  const SettingsScreen({
    super.key,
    required this.deviceName,
    required this.deviceType,
    required this.onSave,
    required double expectedMonthlyUsage,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final powerController = TextEditingController();
  final hoursController = TextEditingController();
  double? calculatedMonthlyConsumption;

  void calculateAndSave() {
    double? power = double.tryParse(powerController.text);
    double? hours = double.tryParse(hoursController.text);
    if (power != null && hours != null) {
      setState(() {
        calculatedMonthlyConsumption = power * hours * 4;
      });
      widget.onSave(power, hours);
    } else {
      widget.onSave(power, hours);
    }
    // Do not pop here, so user can see the result
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.deviceName)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Weekly Time On (h):", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              controller: hoursController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter hours per week (optional)",
              ),
            ),
            SizedBox(height: 24),
            Text("Device Power (kW):", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              controller: powerController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter power in W (optional)",
              ),
            ),
            SizedBox(height: 8),
            Text("1kW = 1000W", style: TextStyle(fontSize: 12, color: Colors.red[800])),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: calculateAndSave,
              child: Text("Save"),
            ),
            if (calculatedMonthlyConsumption != null) ...[
              SizedBox(height: 24),
              Text(
                "Monthly Consumption: ${calculatedMonthlyConsumption!.toStringAsFixed(2)} kWh",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[700]),
              ),
            ],
          ],
        ),
      ),
    );
  }
}