import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab B - Sortable DataTable',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const CarTableScreen(),
    );
  }
}

class Car {
  final String make;
  final String model;
  final int price;

  Car({required this.make, required this.model, required this.price});
}

class CarTableScreen extends StatefulWidget {
  const CarTableScreen({super.key});

  @override
  State<CarTableScreen> createState() => _CarTableScreenState();
}

class _CarTableScreenState extends State<CarTableScreen> {
  int? _sortColumnIndex;
  bool _sortAscending = true;

  final List<Car> _cars = [
    Car(make: 'Toyota', model: 'Vios', price: 89600),
    Car(make: 'Honda', model: 'Civic', price: 131900),
    Car(make: 'Perodua', model: 'Myvi', price: 59900),
    Car(make: 'Proton', model: 'X50', price: 101800),
    Car(make: 'Mazda', model: 'CX-5', price: 148000),
  ];

  void _sort<T>(
      Comparable<T> Function(Car c) getField, int columnIndex, bool ascending) {
    _cars.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lab B: Sortable Car DataTable'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DataTable(
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              columns: [
                DataColumn(
                  label: const Text(
                    'Car Make',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onSort: (columnIndex, ascending) =>
                      _sort<String>((c) => c.make, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text(
                    'Model',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onSort: (columnIndex, ascending) =>
                      _sort<String>((c) => c.model, columnIndex, ascending),
                ),
                DataColumn(
                  label: const Text(
                    'Price (RM)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  numeric: true,
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((c) => c.price, columnIndex, ascending),
                ),
              ],
              rows: _cars.map((car) {
                return DataRow(
                  cells: [
                    DataCell(Text(car.make)),
                    DataCell(Text(car.model)),
                    DataCell(Text(car.price.toString())),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}