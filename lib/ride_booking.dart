import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookRideScreen extends StatefulWidget {
  const BookRideScreen({super.key});

  @override
  State<BookRideScreen> createState() => _BookRideScreenState();
}

class _BookRideScreenState extends State<BookRideScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropController = TextEditingController();
  final TextEditingController _fareController = TextEditingController();
  
  bool _isLoading = false;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  void _getUserId() {
    _userId = _auth.currentUser?.uid;
    if (_userId == null) {
      // If not logged in, use anonymous or show error
      _userId = 'anonymous';
    }
  }

  Future<void> _bookRide() async {
    // Validate inputs
    if (_pickupController.text.isEmpty ||
        _dropController.text.isEmpty ||
        _fareController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseFirestore.instance.collection("rides").add({
        "pickup": _pickupController.text,
        "drop": _dropController.text,
        "fare": int.parse(_fareController.text),
        "status": "pending",
        "userId": _userId,
        "createdAt": FieldValue.serverTimestamp(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ride Booked Successfully! 🎉'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Clear fields
        _pickupController.clear();
        _dropController.clear();
        _fareController.clear();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _dropController.dispose();
    _fareController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Ride',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Icon
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.car_rental,
                    size: 60,
                    color: Colors.orange,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              const Text(
                'Book Your Ride',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your ride details below',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Pickup Field
              TextField(
                controller: _pickupController,
                decoration: InputDecoration(
                  labelText: 'Pickup Location',
                  hintText: 'Enter pickup address',
                  prefixIcon: const Icon(Icons.location_on, color: Colors.orange),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.orange, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Drop Field
              TextField(
                controller: _dropController,
                decoration: InputDecoration(
                  labelText: 'Drop Location',
                  hintText: 'Enter destination address',
                  prefixIcon: const Icon(Icons.flag, color: Colors.orange),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.orange, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Fare Field
              TextField(
                controller: _fareController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Fare (Rs.)',
                  hintText: 'Enter fare amount',
                  prefixIcon: const Icon(Icons.currency_rupee, color: Colors.orange),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.orange, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Book Ride Button
              SizedBox(
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _bookRide,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.book_online),
                            SizedBox(width: 10),
                            Text(
                              'BOOK RIDE',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              
              const Spacer(),
              
              // Footer
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.security, color: Colors.grey, size: 16),
                    const SizedBox(width: 4),
                    const Text(
                      'Secure booking • ',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const Icon(Icons.timer, color: Colors.grey, size: 16),
                    const SizedBox(width: 4),
                    const Text(
                      'Fast response',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
