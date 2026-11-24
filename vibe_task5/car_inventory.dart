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
  double? minPrice;
  double? maxPrice;
  late List> filteredCars;

  @override
  void initState() {
    super.initState();
    filteredCars = List.from(cars);
  }

  void _applyFilters() {
    final currentMin = minPrice;
    final currentMax = maxPrice;

    setState(() {
      filteredCars = cars.where((car) {
        final matchesName = car['name']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase());
        final double price = (car['price'] as num?)?.toDouble() ?? 0.0;
        final matchesMin = currentMin == null || price >= currentMin;
        final matchesMax = currentMax == null || price <= currentMax;
        return matchesName && matchesMin && matchesMax;
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Car Inventory (${filteredCars.length})')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search cars',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    query = '';
                    minPrice = null;
                    maxPrice = null;
                    _applyFilters();
                  },
                ),
              ),
              onChanged: (val) {
                query = val;
                _applyFilters();
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  maxPrice = 90000.0;
                  _applyFilters();
                },
                child: const Text('Under RM90k'),
              ),
              ElevatedButton(
                onPressed: () {
                  minPrice = null;
                  maxPrice = null;
                  _applyFilters();
                },
                child: const Text('All Prices'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCars.length,
              itemBuilder: (context, index) {
                final item = filteredCars[index];
                final price = (item['price'] as num?)?.toDouble() ?? 0.0;
                return ListTile(
                  title: Text(item['name'].toString()),
                  subtitle: Text('RM ${price.toStringAsFixed(0)}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}