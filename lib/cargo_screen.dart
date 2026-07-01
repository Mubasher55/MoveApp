import 'package:flutter/material.dart';

class CargoScreen extends StatelessWidget {
  const CargoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Cargo Truck"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildField("Pickup City"),
            const SizedBox(height: 20),
            buildField("Destination City"),
            const SizedBox(height: 20),
            buildField("Load Weight"),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text("Find Truck"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
