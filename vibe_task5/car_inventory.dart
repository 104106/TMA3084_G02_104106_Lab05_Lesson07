import 'package:flutter/material.dart';

class CarInventoryScreen extends StatefulWidget {
  const CarInventoryScreen({super.key});

  @override
  State<CarInventoryScreen> createState() => _CarInventoryScreenState();
}

class _CarInventoryScreenState extends State<CarInventoryScreen> {
  final List<String> cars = ['Toyota Vios', 'Honda Civic', 'Perodua Myvi'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Car Inventory')),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) => ListTile(title: Text(cars[index])),
      ),
    );
  }
}