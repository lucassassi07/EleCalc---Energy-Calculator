import 'package:flutter/material.dart';

class Device {
  String name;
  String type;
  IconData icon;
  double? power; // kW
  double? weeklyTimeOn; // hours per week

  Device({
    required this.name,
    required this.type,
    required this.icon,
    this.power,
    this.weeklyTimeOn,
  });

  double get monthlyUsage => (power != null && weeklyTimeOn != null) ? power! * weeklyTimeOn! * 4 : 0;
  double get weeklyUsage => (power != null && weeklyTimeOn != null) ? power! * weeklyTimeOn! : 0;
  double get dailyUsage => (power != null && weeklyTimeOn != null) ? (power! * weeklyTimeOn! * 4) / 30 : 0;
}

// Add this map for average power ranges
const Map<String, String> avgPowerRanges = {
  "AC": "1–3.5 kW",
  "Dishwasher": "1.2–2.4 kW",
  "Dryer": "1.8–5 kW",
  "EV": "7–11 kW",
  "Fan": "0.05–0.1 kW",
  "Hairdryer": "1.2–1.8 kW",
  "Heater": "1.5–3 kW",
  "Microwave": "0.8–1.2 kW",
  "Oven": "2–3.5 kW",
  "PC": "0.2–0.6 kW",
  "Refrigerator": "0.1–0.3 kW",
  "TV": "0.08–0.25 kW",
  "Washer": "0.4–1.2 kW",
};

class DeviceCard extends StatelessWidget {
  final Device device;
  final VoidCallback onSettings;
  final VoidCallback onDelete;

  const DeviceCard({
    super.key,
    required this.device,
    required this.onSettings,
    required this.onDelete,
  });

  String getAvgPowerRange(String type) {
    // For TV, handle both "TV" and "Television"
    if (type == "Television") return avgPowerRanges["TV"] ?? "";
    return avgPowerRanges[type] ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final avgPower = getAvgPowerRange(device.type);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(device.icon, color: Colors.blue, size: 28),
                SizedBox(width: 8),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        device.name,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      if (avgPower.isNotEmpty) ...[
                        SizedBox(width: 6),
                        Text(
                          "($avgPower)",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: onSettings,
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text("Power (kW)", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900])),
                      Text(device.power != null ? device.power!.toStringAsFixed(2) : "-", style: TextStyle(color: Colors.black, fontSize: 20)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("Weekly Time On (h)", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900])),
                      Text(device.weeklyTimeOn != null ? device.weeklyTimeOn!.toStringAsFixed(1) : "-", style: TextStyle(color: Colors.black, fontSize: 20)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text("Month (kWh)", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[700])),
                      Text(device.monthlyUsage.toStringAsFixed(1), style: TextStyle(color: Colors.black, fontSize: 20)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("Week (kWh)", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[700])),
                      Text(device.weeklyUsage.toStringAsFixed(1), style: TextStyle(color: Colors.black, fontSize: 20)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("Day (kWh)", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[700])),
                      Text(device.dailyUsage.toStringAsFixed(1), style: TextStyle(color: Colors.black, fontSize: 20)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
