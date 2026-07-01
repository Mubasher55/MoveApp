import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ride_status_screen.dart';

class BookRideScreen extends StatefulWidget {
  const BookRideScreen({super.key});

  @override
  State<BookRideScreen> createState() => _BookRideScreenState();
}

class _BookRideScreenState extends State<BookRideScreen> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropController = TextEditingController();
  final TextEditingController _fareController = TextEditingController();

  bool _isLoading = false;

  Future<void> _bookRide() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please Login First")),
      );
      return;
    }

    if (_pickupController.text.isEmpty ||
        _dropController.text.isEmpty ||
        _fareController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      DocumentReference rideRef =
          await FirebaseFirestore.instance.collection("rides").add({
        "pickup": _pickupController.text.trim(),
        "drop": _dropController.text.trim(),
        "fare": double.parse(_fareController.text.trim()),
        "currency": "PKR",
        "status": "Searching Driver",
        "driver": "",
        "carType": "Car",
        "userId": user.uid,
        "createdAt": FieldValue.serverTimestamp(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Text("Ride Booked Successfully 🚖"),
  ),
);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => RideStatusScreen(
            rideId: rideRef.id,
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _dropController.dispose();
    _fareController.dispose();
    super.dispose();
  }

  Widget buildField(
    TextEditingController controller,
    String hint,
    IconData icon,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Ride"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            buildField(
              _pickupController,
              "Pickup Location",
              Icons.my_location,
            ),

            const SizedBox(height: 20),

            buildField(
              _dropController,
              "Drop Location",
              Icons.location_on,
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _fareController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.payments),
                labelText: "Offer Fare",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                onPressed: _isLoading ? null : _bookRide,
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "BOOK RIDE",
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}                
