import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ride_status_screen.dart';

class RideBookingScreen extends StatefulWidget {
  const RideBookingScreen({super.key});

  @override
  State<RideBookingScreen> createState() => _RideBookingScreenState();
}

class _RideBookingScreenState extends State<RideBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final pickupController = TextEditingController();
  final dropController = TextEditingController();
  final fareController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    pickupController.dispose();
    dropController.dispose();
    fareController.dispose();
    super.dispose();
  }

  Future<String> _bookRide() async {
    // Dismiss keyboard and validate
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      throw Exception('Please fix the errors');
    }

    // Parse fare as double
    final fareValue = double.tryParse(fareController.text.trim());
    if (fareValue == null || fareValue <= 0) {
      throw Exception('Enter a valid fare amount');
    }

    // Write to Firestore
    final docRef = await FirebaseFirestore.instance.collection("rides").add({
      "pickup": pickupController.text.trim(),
      "drop": dropController.text.trim(),
      "fare": fareValue,                     // stored as number
      "status": "pending",
      "driverId": "",
      "createdAt": FieldValue.serverTimestamp(),  // server timestamp is better
    });

    return docRef.id;
  }

  void _onBookRide() async {
    setState(() => _isLoading = true);
    try {
      final rideId = await _bookRide();

      // Clear form
      pickupController.clear();
      dropController.clear();
      fareController.clear();

      // Navigate to status screen
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RideStatusScreen(rideId: rideId),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Book Ride"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: pickupController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration("Pickup Location"),
                validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: dropController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration("Drop Location"),
                validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: fareController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration("Fare Offer (\$)"),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Required';
                  final val = double.tryParse(v.trim());
                  if (val == null || val <= 0) return 'Invalid fare';
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _onBookRide,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text("BOOK RIDE", style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[600]),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey[700]!),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.orange),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      filled: true,
      fillColor: Colors.grey[900],
    );
  }
}
