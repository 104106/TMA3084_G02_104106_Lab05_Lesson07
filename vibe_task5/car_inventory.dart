import 'package:flutter/material.dart';

class CarInventoryScreen extends StatefulWidget {
  const CarInventoryScreen({super.key});

  @override
  State<CarInventoryScreen> createState() => _CarInventoryScreenState();
}

class _CarInventoryScreenState extends State<CarInventoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List> cars = [
    {'name': 'Toyota Vios', 'price': 85000.0},
    {'name': 'Honda Civic', 'price': 135000.0},
    {'name': 'Perodua Myvi', 'price': 55000.0},
    {'name': 'Proton X50', 'price': 95000.0},
  ];

  String query = '';
  double? minP;
  double? maxP;
  int tempCount = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = cars.where((c) {
      final matchesName =
          c['name'].toString().toLowerCase().contains(query.toLowerCase());
      final double price = c['price'];
      final matchesMin = minP == null || price >= minP!;
      final matchesMax = maxP == null || price <= maxP!;
      return matchesName && matchesMin && matchesMax;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Car Inventory (${filtered.length})')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search cars',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      query = '';
                      minP = null;
                      maxP = null;
                    });
                  },
                ),
              ),
              onChanged: (val) => setState(() => query = val),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => setState(() => maxP = 90000.0),
                child: Text('Under RM90k'),
              ),
              ElevatedButton(
                onPressed: () => setState(() {
                  minP = null;
                  maxP = null;
                }),
                child: Text('All Prices'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final item = filtered[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text('RM ${item['price'].toStringAsFixed(0)}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}