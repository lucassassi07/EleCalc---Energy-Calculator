import 'package:flutter/material.dart';
import 'device_card.dart';
// ignore: depend_on_referenced_packages
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  String selectedState = 'AL';
  TextEditingController monthlyTargetController = TextEditingController();
  double? totalMonthlyTarget;

  late TabController _tabController;

  String analyticsTimeUnit = 'Days'; // 'Days', 'Weeks', 'Months'

  final List<Map<String, dynamic>> devices = [];

  final Map<String, String> avgMonthlyBill = {
    'AL': '\$115.00',
    'AK': '\$198.10',
    'AZ': '\$118.76',
    'AR': '\$101.92',
    'CA': '\$258.38',
    'CO': '\$122.52',
    'CT': '\$223.50',
    'DE': '\$124.49',
    'FL': '\$126.37',
    'GA': '\$116.88',
    'HI': '\$361.98',
    'ID': '\$93.11',
    'IL': '\$120.73',
    'IN': '\$119.53',
    'IA': '\$108.33',
    'KS': '\$113.20',
    'KY': '\$105.51',
    'LA': '\$98.84',
    'ME': '\$191.95',
    'MD': '\$135.86',
    'MA': '\$235.64',
    'MI': '\$147.32',
    'MN': '\$125.43',
    'MS': '\$109.27',
    'MO': '\$106.45',
    'MT': '\$103.63',
    'NE': '\$96.96',
    'NV': '\$115.94',
    'NH': '\$203.32',
    'NJ': '\$149.20',
    'NM': '\$113.12',
    'NY': '\$195.71',
    'NC': '\$112.18',
    'ND': '\$87.30',
    'OH': '\$124.49',
    'OK': '\$100.72',
    'OR': '\$105.51',
    'PA': '\$133.98',
    'RI': '\$217.60',
    'SC': '\$118.76',
    'SD': '\$99.78',
    'TN': '\$104.57',
    'TX': '\$170.63',
    'UT': '\$97.90',
    'VT': '\$172.03',
    'VA': '\$153.02',
    'WA': '\$90.29',
    'WV': '\$110.21',
    'WI': '\$180.00',
    'WY': '\$96.02',
  };

  final Map<String, double> stateCO2Constants = {
    'AL': 0.3406, 'AK': 0.4173, 'AZ': 0.3288, 'AR': 0.4930, 'CA': 0.2173,
    'CO': 0.5517, 'CT': 0.2336, 'DE': 0.3936, 'FL': 0.3786, 'GA': 0.3441,
    'HI': 0.6762, 'ID': 0.1231, 'IL': 0.2964, 'IN': 0.7407, 'IA': 0.3488,
    'KS': 0.3805, 'KY': 0.7836, 'LA': 0.3749, 'ME': 0.1366, 'MD': 0.3168,
    'MA': 0.3863, 'MI': 0.4551, 'MN': 0.3749, 'MS': 0.3785, 'MO': 0.7430,
    'MT': 0.4742, 'NE': 0.5101, 'NV': 0.3246, 'NH': 0.1379, 'NJ': 0.2183,
    'NM': 0.5148, 'NY': 0.2066, 'NC': 0.3037, 'ND': 0.6079, 'OH': 0.5485,
    'OK': 0.3416, 'OR': 0.1477, 'PA': 0.3295, 'RI': 0.3781, 'SC': 0.2573,
    'SD': 0.1374, 'TN': 0.3169, 'TX': 0.3888, 'UT': 0.7077, 'VT': 0.0163,
    'VA': 0.2718, 'WA': 0.0916, 'WV': 0.8819, 'WI': 0.5746, 'WY': 0.8320,
  };
  
  double? get costInterval => null;
  
  double? get energyInterval => null;

  double getKwhRate() {
    switch (selectedState) {
      case 'AL': return 0.16;
      case 'AK': return 0.26;
      case 'AZ': return 0.15;
      case 'AR': return 0.13;
      case 'CA': return 0.35;
      case 'CO': return 0.16;
      case 'CT': return 0.32;
      case 'DE': return 0.18;
      case 'FL': return 0.15;
      case 'GA': return 0.15;
      case 'HI': return 0.41;
      case 'ID': return 0.12;
      case 'IL': return 0.19;
      case 'IN': return 0.17;
      case 'IA': return 0.14;
      case 'KS': return 0.15;
      case 'KY': return 0.14;
      case 'LA': return 0.13;
      case 'ME': return 0.28;
      case 'MD': return 0.19;
      case 'MA': return 0.30;
      case 'MI': return 0.20;
      case 'MN': return 0.16;
      case 'MS': return 0.15;
      case 'MO': return 0.13;
      case 'MT': return 0.13;
      case 'NE': return 0.13;
      case 'NV': return 0.13;
      case 'NH': return 0.24;
      case 'NJ': return 0.21;
      case 'NM': return 0.15;
      case 'NY': return 0.27;
      case 'NC': return 0.14;
      case 'ND': return 0.13;
      case 'OH': return 0.17;
      case 'OK': return 0.13;
      case 'OR': return 0.16;
      case 'PA': return 0.19;
      case 'RI': return 0.29;
      case 'SC': return 0.15;
      case 'SD': return 0.14;
      case 'TN': return 0.14;
      case 'TX': return 0.16;
      case 'UT': return 0.12;
      case 'VT': return 0.24;
      case 'VA': return 0.16;
      case 'WA': return 0.14;
      case 'WV': return 0.16;
      case 'WI': return 0.19;
      case 'WY': return 0.14;
      default: return 0.35;
    }
  }

  String getCurrentDateString() {
    final now = DateTime.now();
    final months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return "${months[now.month - 1]} ${now.day}, ${now.year}";
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Calculate expected total kWh from user input (no fixed values)
  double getExpectedTotalKwh() {
    return devices.fold(
      0.0,
          (sum, device) {
        final power = device["power"];
        final weeklyTimeOn = device["weeklyTimeOn"];
        return sum + ((power != null && weeklyTimeOn != null) ? power * weeklyTimeOn * 4 : 0.0);
      },
    );
  }

  double getExpectedTotalCost() {
    return getExpectedTotalKwh() * getKwhRate();
  }

  double getCO2Emission() {
    double expectedKwh = getExpectedTotalKwh();
    double co2Constant = stateCO2Constants[selectedState] ?? 0.35;
    return expectedKwh * co2Constant;
  }

  List<String> getXAxisLabels() {
    switch (analyticsTimeUnit) {
      case 'Weeks': return List.generate(5, (i) => '${i + 1}');
      case 'Months': return List.generate(12, (i) => '${i + 1}');
      default: return List.generate(31, (i) => '${i + 1}');
    }
  }

  Map<String, double> userMonthlyKwh = {}; // e.g. {"January": 600}
  Map<String, double> userMonthlyCost = {}; // e.g. {"January": 120.0}
  String selectedMonth = "January";
  TextEditingController kwhController = TextEditingController();
  TextEditingController costController = TextEditingController();

  final List<String> months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  @override
  Widget build(BuildContext context) {
    double? totalMonthlyKwh = totalMonthlyTarget != null
        ? totalMonthlyTarget! / getKwhRate()
        : null;

    double expectedTotalKwh = getExpectedTotalKwh();
    double expectedTotalCost = getExpectedTotalCost();

    bool belowTarget = totalMonthlyKwh != null && expectedTotalKwh <= totalMonthlyKwh &&
        totalMonthlyTarget != null &&
        expectedTotalCost <= totalMonthlyTarget!;

    Color statusColor = belowTarget ? Colors.green : Colors.red;
    String statusText = belowTarget ? "achieving target" : "exceeding target";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Row(
          children: [
            Icon(Icons.flash_on, size: 40, color: Colors.white),
            const SizedBox(width: 4),
            Text("EleCalc", style: TextStyle(fontSize: 32, color: Colors.white)),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Energy Simulator",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Select your state",
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    DropdownButton<String>(
                      value: selectedState,
                      dropdownColor: Colors.blue[50],
                      icon: Icon(Icons.arrow_drop_down, color: Colors.blue[700]),
                      underline: SizedBox(),
                      style: TextStyle(
                          color: Colors.blue[700], fontWeight: FontWeight.bold),
                      items: [
                        'AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY'
                      ]
                          .map((state) => DropdownMenuItem<String>(
                                value: state,
                                child: Text(state),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedState = value;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              getCurrentDateString(),
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ),
          // Tabs
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Analytics'),
            ],
            labelColor: Colors.blue[700],
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue[700],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Overview tab: make scrollable
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: monthlyTargetController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Total Monthly Target (\$)',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  totalMonthlyTarget = double.tryParse(value);
                                });
                              },
                            ),
                            if (totalMonthlyKwh != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'This is ${totalMonthlyKwh.toStringAsFixed(1)} kWh per month',
                                  style: TextStyle(color: Colors.blue[700]),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Move "Expected Consumption" up
                                  Text("Consumption (kWh)", style: TextStyle(color: Colors.black)),
                                  SizedBox(height: 4),
                                  Text(
                                    expectedTotalKwh.toStringAsFixed(1),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: statusColor),
                                  ),
                                  Text(
                                    statusText,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: statusColor),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 32),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Move "Expected Cost" up
                                  Text("Cost (\$)", style: TextStyle(color: Colors.black)),
                                  SizedBox(height: 4),
                                  Text(
                                    expectedTotalCost.toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: statusColor),
                                  ),
                                  Text(
                                    statusText,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: statusColor),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 32),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("CO2 Emission (kg) / month", style: TextStyle(color: Colors.black)),
                                SizedBox(height: 4),
                                Text(
                                  getCO2Emission().toStringAsFixed(2),
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "${(getCO2Emission() * 3).toStringAsFixed(0)} miles driven",
                                  style: TextStyle(fontSize: 14, color: Colors.red[800]),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  "${(getCO2Emission() * 0.6).toStringAsFixed(1)} trees to absorb",
                                  style: TextStyle(fontSize: 14, color: Colors.green[700]),
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "State Average",
                                  style: TextStyle(color: Colors.black),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  avgMonthlyBill[selectedState] ?? '',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 1.3,
                          ),
                          itemCount: devices.length,
                          itemBuilder: (context, index) {
                            final device = devices[index];
                            final deviceTypes = {
                              "AC": Icons.ac_unit,
                              "Dishwasher": Icons.water,
                              "Dryer": Icons.dry_cleaning,                           
                              "EV": Icons.ev_station,
                              "Fan": Icons.wind_power,
                              "Hairdryer": Icons.face,
                              "Heater": Icons.fireplace,
                              "Microwave": Icons.microwave,
                              "Oven": Icons.heat_pump,
                              "PC": Icons.computer,
                              "Refrigerator": Icons.kitchen,
                              "TV": Icons.tv,
                              "Washer": Icons.local_laundry_service,
                              "Other": Icons.device_unknown,
                            };
                            IconData deviceIcon = deviceTypes[device["type"]] ?? Icons.device_unknown;

                            return DeviceCard(
                              device: Device(
                                name: device["name"],
                                type: device["type"],
                                icon: deviceIcon,
                                power: device["power"],
                                weeklyTimeOn: device["weeklyTimeOn"],
                              ),
                              onSettings: () async {
                                final result = await showDialog<Map<String, dynamic>>(
                                  context: context,
                                  builder: (context) {
                                    final powerController = TextEditingController(
                                      text: device["power"]?.toString() ?? '',
                                    );
                                    final weeklyTimeController = TextEditingController(
                                      text: device["weeklyTimeOn"]?.toString() ?? '',
                                    );
                                    return AlertDialog(
                                      title: Text('Device Settings'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: powerController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelText: 'Device Power (kW)',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          TextField(
                                            controller: weeklyTimeController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              labelText: 'Weekly Time On (h)',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text("1kW = 1000W", style: TextStyle(fontSize: 12, color: Colors.red[800])),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text('Cancel'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            double? power = double.tryParse(powerController.text);
                                            double? weeklyTimeOn = double.tryParse(weeklyTimeController.text);
                                            Navigator.pop(context, {
                                              "power": power,
                                              "weeklyTimeOn": weeklyTimeOn,
                                            });
                                          },
                                          child: Text('Save'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                if (result != null) {
                                  setState(() {
                                    device["power"] = result["power"];
                                    device["weeklyTimeOn"] = result["weeklyTimeOn"];
                                  });
                                }
                              },
                              onDelete: () {
                                setState(() {
                                  devices.removeAt(index);
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // Analytics tab: X axis static, Y axis dynamic
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DropdownButton<String>(
                              icon: Icon(Icons.arrow_drop_down, color: Colors.red[800]),
                              value: analyticsTimeUnit,
                              items: ['Days', 'Weeks', 'Months']
                                  .map((unit) => DropdownMenuItem<String>(
                                        value: unit,
                                        child: Text(unit, style: TextStyle(fontSize: 14, color: Colors.red[800])),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    analyticsTimeUnit = value;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        // Input boxes for month and kWh
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                initialValue: selectedMonth,
                                decoration: InputDecoration(labelText: "Month"),
                                items: months.map((month) => DropdownMenuItem(
                                  value: month,
                                  child: Text(month),
                                )).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      selectedMonth = value;
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                controller: kwhController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "kWh from bill",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                controller: costController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Cost from bill (\$)",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {
                                double? kwhValue = double.tryParse(kwhController.text);
                                double? costValue = double.tryParse(costController.text);
                                setState(() {
                                  if (kwhValue != null) {
                                    userMonthlyKwh[selectedMonth] = kwhValue;
                                    kwhController.clear();
                                  }
                                  if (costValue != null) {
                                    userMonthlyCost[selectedMonth] = costValue;
                                    costController.clear();
                                  }
                                });
                              },
                              child: Text("Add"),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Energy Consumption Graph (left)
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Energy Consumption (kWh)',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  AspectRatio(
                                    aspectRatio: 1.8,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: LineChart(
                                        LineChartData(
                                          minY: getYAxisLabelsEnergy(totalMonthlyTarget, analyticsTimeUnit, getKwhRate()).first,
                                          maxY: getYAxisLabelsEnergy(totalMonthlyTarget, analyticsTimeUnit, getKwhRate()).last,
                                          lineBarsData: [
                                            // Only show user input points (blue dots), no lines
                                            LineChartBarData(
                                              spots: List.generate(
                                                12,
                                                (i) {
                                                  String month = months[i];
                                                  double? userValue = userMonthlyKwh[month];
                                                  return userValue != null
                                                      ? FlSpot(i.toDouble(), userValue)
                                                      : FlSpot(i.toDouble(), double.nan);
                                                },
                                              ).where((spot) => !spot.y.isNaN).toList(),
                                              isCurved: false,
                                        
                                              dotData: FlDotData(show: true),
                                              barWidth: 0, // Only show dots, no connecting line
                                            ),
                                          ],
                                          extraLinesData: ExtraLinesData(
                                            horizontalLines: [
                                              HorizontalLine(
                                                y: () {
                                                  double kwhRate = getKwhRate();
                                                  if (analyticsTimeUnit == 'Months') {
                                                    return (totalMonthlyTarget ?? 0) / (kwhRate == 0 ? 1 : kwhRate);
                                                  } else if (analyticsTimeUnit == 'Weeks') {
                                                    return ((totalMonthlyTarget ?? 0) / (kwhRate == 0 ? 1 : kwhRate)) / 4;
                                                  } else {
                                                    return ((totalMonthlyTarget ?? 0) / (kwhRate == 0 ? 1 : kwhRate)) / 30;
                                                  }
                                                }(),
                                                color: Colors.red,
                                                strokeWidth: 3,
                                                dashArray: [8, 0],
                                              ),
                                            ],
                                          ),
                                          titlesData: FlTitlesData(
                                            leftTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                getTitlesWidget: (value, meta) {
                                                  final yLabels = getYAxisLabelsEnergy(totalMonthlyTarget, analyticsTimeUnit, getKwhRate());
                                                  if (yLabels.contains(double.parse(value.toStringAsFixed(1)))) {
                                                    return Text(value.toStringAsFixed(1), style: TextStyle(fontSize: 10));
                                                  }
                                                  return const SizedBox.shrink();
                                                },
                                                interval: energyInterval,
                                                reservedSize: 40,
                                              ),
                                            ),
                                            bottomTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                getTitlesWidget: (value, meta) {
                                                  int idx = value.toInt();
                                                  final labels = getXAxisLabels();
                                                  return idx >= 0 && idx < labels.length
                                                      ? Text(labels[idx], style: TextStyle(fontSize: 10))
                                                      : Text('');
                                                },
                                                interval: 1,
                                              ),
                                            ),
                                            topTitles: AxisTitles(
                                              sideTitles: SideTitles(showTitles: false),
                                            ),
                                            rightTitles: AxisTitles(
                                              sideTitles: SideTitles(showTitles: false),
                                            ),
                                          ),
                                          gridData: FlGridData(show: true),
                                          borderData: FlBorderData(show: true),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 24),
                            // Cost Graph (right)
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Cost (\$)',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  AspectRatio(
                                    aspectRatio: 1.8,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: LineChart(
                                        LineChartData(
                                          minY: getYAxisLabelsCost(totalMonthlyTarget, analyticsTimeUnit).first,
                                          maxY: getYAxisLabelsCost(totalMonthlyTarget, analyticsTimeUnit).last,
                                          lineBarsData: [
                                            // Only show user input cost points (blue dots), no lines
                                            LineChartBarData(
                                              spots: List.generate(
                                                12,
                                                (i) {
                                                  String month = months[i];
                                                  double? userValue = userMonthlyCost[month];
                                                  return userValue != null
                                                      ? FlSpot(i.toDouble(), userValue)
                                                      : FlSpot(i.toDouble(), double.nan);
                                                },
                                              ).where((spot) => !spot.y.isNaN).toList(),
                                              isCurved: false,
                                         
                                              dotData: FlDotData(show: true),
                                              barWidth: 0, // Only show dots, no connecting line
                                            ),
                                          ],
                                          extraLinesData: ExtraLinesData(
                                            horizontalLines: [
                                              HorizontalLine(
                                                y: () {
                                                  if (analyticsTimeUnit == 'Months') {
                                                    return totalMonthlyTarget ?? 0;
                                                  } else if (analyticsTimeUnit == 'Weeks') {
                                                    return (totalMonthlyTarget ?? 0) / 4;
                                                  } else {
                                                    return (totalMonthlyTarget ?? 0) / 30;
                                                  }
                                                }(),
                                                color: Colors.red,
                                                strokeWidth: 3,
                                                dashArray: [8, 0],
                                              ),
                                            ],
                                          ),
                                          titlesData: FlTitlesData(
                                            leftTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                getTitlesWidget: (value, meta) {
                                                  final yLabels = getYAxisLabelsCost(totalMonthlyTarget, analyticsTimeUnit);
                                                  if (yLabels.contains(double.parse(value.toStringAsFixed(1)))) {
                                                    return Text(value.toStringAsFixed(1), style: TextStyle(fontSize: 10));
                                                  }
                                                  return const SizedBox.shrink();
                                                },
                                                interval: costInterval,
                                                reservedSize: 40,
                                              ),
                                            ),
                                            bottomTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                getTitlesWidget: (value, meta) {
                                                  int idx = value.toInt();
                                                  final labels = getXAxisLabels();
                                                  return idx >= 0 && idx < labels.length
                                                      ? Text(labels[idx], style: TextStyle(fontSize: 10))
                                                      : Text('');
                                                },
                                                interval: 1,
                                              ),
                                            ),
                                            topTitles: AxisTitles(
                                              sideTitles: SideTitles(showTitles: false),
                                            ),
                                            rightTitles: AxisTitles(
                                              sideTitles: SideTitles(showTitles: false),
                                            ),
                                          ),
                                          gridData: FlGridData(show: true),
                                          borderData: FlBorderData(show: true),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final deviceTypes = {
            "AC": Icons.ac_unit,
            "Dishwasher": Icons.water,
            "Dryer": Icons.dry_cleaning,
            "EV": Icons.ev_station,
            "Fan": Icons.wind_power,
            "Hairdryer": Icons.face,
            "Heater": Icons.fireplace,
            "Microwave": Icons.microwave,
            "Oven": Icons.heat_pump,
            "PC": Icons.computer,
            "Refrigerator": Icons.kitchen,
            "TV": Icons.tv,
            "Washer": Icons.local_laundry_service,
            "Other": Icons.device_unknown,
          };
          String selectedType = deviceTypes.keys.first;
          int quantity = 1;
          final newDevice = await showDialog<Map<String, dynamic>>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add New Device'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: selectedType,
                      decoration: InputDecoration(labelText: 'Device Type'),
                      items: deviceTypes.keys
                          .map((type) => DropdownMenuItem<String>(
                                value: type,
                                child: Row(
                                  children: [
                                    Icon(deviceTypes[type], color: Colors.blue),
                                    SizedBox(width: 8),
                                    Text(type),
                                  ],
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) selectedType = value;
                      },
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<int>(
                      initialValue: quantity,
                      decoration: InputDecoration(labelText: 'Quantity'),
                      items: List.generate(20, (i) => i + 1)
                          // ignore: avoid_types_as_parameter_names
                          .map((num) => DropdownMenuItem<int>(
                                value: num,
                                child: Text(num.toString()),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) quantity = value;
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedType.isNotEmpty && quantity > 0) {
                        Navigator.pop(context, {
                          "type": selectedType,
                          "quantity": quantity,
                        });
                      }
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
          if (newDevice != null) {
            setState(() {
              for (int i = 0; i < newDevice["quantity"]; i++) {
                devices.add({
                  "name": newDevice["type"] + (newDevice["quantity"] > 1 ? " #${i + 1}" : ""),
                  "type": newDevice["type"],
                });
              }
            });
          }
        },
        tooltip: 'Add Device',
        child: Icon(Icons.add),
      ),
    );
  }

  List<double> getYAxisLabelsCost(double? totalMonthlyTarget, String analyticsTimeUnit) {
  if (totalMonthlyTarget == null || totalMonthlyTarget <= 0) {
    // Default labels if no input
    switch (analyticsTimeUnit) {
      case 'Months':
        return List.generate(12, (i) => (i + 1) * 5.0);
      case 'Weeks':
        return List.generate(5, (i) => (i + 1) * 5.0);
      default: // Days
        return List.generate(31, (i) => (i + 1) * 0.1);
    }
  }

  if (analyticsTimeUnit == 'Months') {
    // 12 labels: 5 below, input in middle, 6 above
    double middle = totalMonthlyTarget;
    List<double> labels = [];
    // 5 below
    for (int i = 5; i >= 1; i--) {
      labels.add(double.parse((middle - i * 5).toStringAsFixed(1)));
    }
    // middle
    labels.add(double.parse(middle.toStringAsFixed(1)));
    // 6 above
    for (int i = 1; i <= 6; i++) {
      labels.add(double.parse((middle + i * 5).toStringAsFixed(1)));
    }
    return labels;
  } else if (analyticsTimeUnit == 'Weeks') {
    // 5 labels: 2 below, input/4 in middle, 2 above
    double middle = totalMonthlyTarget / 4;
    List<double> labels = [];
    // 2 below
    for (int i = 2; i >= 1; i--) {
      labels.add(double.parse((middle - i * 2).toStringAsFixed(1)));
    }
    // middle
    labels.add(double.parse(middle.toStringAsFixed(1)));
    // 2 above
    for (int i = 1; i <= 2; i++) {
      labels.add(double.parse((middle + i * 2).toStringAsFixed(1)));
    }
    return labels;
  } else {
    // Days: 31 labels, 15 below, input/30 in middle, 15 above
    double middle = totalMonthlyTarget / 30;
    List<double> labels = [];
    // 15 below
    for (int i = 15; i >= 1; i--) {
      labels.add(double.parse((middle - i * 0.1).toStringAsFixed(1)));
    }
    // middle
    labels.add(double.parse(middle.toStringAsFixed(1)));
    // 15 above
    for (int i = 1; i <= 15; i++) {
      labels.add(double.parse((middle + i * 0.1).toStringAsFixed(1)));
    }
    return labels;
  }
}

List<double> getYAxisLabelsEnergy(double? totalMonthlyTarget, String analyticsTimeUnit, double kwhRate) {
  if (totalMonthlyTarget == null || totalMonthlyTarget <= 0 || kwhRate <= 0) {
    // Default labels if no input
    switch (analyticsTimeUnit) {
      case 'Months':
        return List.generate(12, (i) => (i + 1) * 5.0);
      case 'Weeks':
        return List.generate(5, (i) => (i + 1) * 5.0);
      default: // Days
        return List.generate(31, (i) => (i + 1) * 0.1);
    }
  }

  // Convert cost to kWh
  double totalMonthlyKwh = totalMonthlyTarget / kwhRate;

  if (analyticsTimeUnit == 'Months') {
    // 12 labels: 5 below, input in middle, 6 above
    double middle = totalMonthlyKwh;
    List<double> labels = [];
    // 5 below
    for (int i = 5; i >= 1; i--) {
      labels.add(double.parse((middle - i * 5).toStringAsFixed(1)));
    }
    // middle
    labels.add(double.parse(middle.toStringAsFixed(1)));
    // 6 above
    for (int i = 1; i <= 6; i++) {
      labels.add(double.parse((middle + i * 5).toStringAsFixed(1)));
    }
    return labels;
  } else if (analyticsTimeUnit == 'Weeks') {
    // 5 labels: 2 below, input/4 in middle, 2 above
    double middle = totalMonthlyKwh / 4;
    List<double> labels = [];
    // 2 below
    for (int i = 2; i >= 1; i--) {
      labels.add(double.parse((middle - i * 2).toStringAsFixed(1)));
    }
    // middle
    labels.add(double.parse(middle.toStringAsFixed(1)));
    // 2 above
    for (int i = 1; i <= 2; i++) {
      labels.add(double.parse((middle + i * 2).toStringAsFixed(1)));
    }
    return labels;
  } else {
    // Days: 31 labels, 15 below, input/30 in middle, 15 above
    double middle = totalMonthlyKwh / 30;
    List<double> labels = [];
    // 15 below
    for (int i = 15; i >= 1; i--) {
      labels.add(double.parse((middle - i * 0.1).toStringAsFixed(1)));
    }
    // middle
    labels.add(double.parse(middle.toStringAsFixed(1)));
    // 15 above
    for (int i = 1; i <= 15; i++) {
      labels.add(double.parse((middle + i * 0.1).toStringAsFixed(1)));
    }
    return labels;
  }
}
}