import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  StreamSubscription<Position>? _locationSubscription;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _driverId = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthAndStartTracking();
    });
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  void _checkAuthAndStartTracking() {
    final user = _auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login first')),
      );
      return;
    }

    _driverId = user.uid;
    startTracking();
  }

  Future<void> startTracking() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    _locationSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5,
      ),
    ).listen((position) {
      FirebaseFirestore.instance
          .collection("drivers")
          .doc(_driverId)
          .set({
        "lat": position.latitude,
        "lng": position.longitude,
        "status": "online",
        "updatedAt": FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    });
  }

  Future<void> acceptRide(String rideId) async {
    await FirebaseFirestore.instance.collection("rides").doc(rideId).update({
      "status": "accepted",
      "driverId": _driverId,
    });
  }

  Future<void> startRide(String rideId) async {
    await FirebaseFirestore.instance.collection("rides").doc(rideId).update({
      "status": "started",
    });
  }

  Future<void> endRide(String rideId) async {
    await FirebaseFirestore.instance.collection("rides").doc(rideId).update({
      "status": "completed",
      "paymentStatus": "paid",
      "completedAt": FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Driver Panel"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            color: Colors.grey.shade900,
            child: const Center(
              child: Text(
                "Live Tracking Running...",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("rides")
                  .where("status", isEqualTo: "pending")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final rides = snapshot.data!.docs;

                if (rides.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Pending Rides",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: rides.length,
                  itemBuilder: (context, index) {
                    final ride = rides[index];

                    return Card(
                      color: Colors.grey.shade900,
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${ride["pickup"]} → ${ride["drop"]}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Row(
                              children: [
                                const Icon(Icons.currency_rupee,
                                    color: Colors.green),
                                const SizedBox(width: 5),
                                Text(
                                  "Fare: PKR ${ride["fare"]}",
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            Text(
                              "Status: ${ride["status"]}",
                              style: const TextStyle(color: Colors.orange),
                            ),

                            const SizedBox(height: 15),

                            Wrap(
                              spacing: 10,
                              children: [
                                ElevatedButton(
                                  onPressed: () => acceptRide(ride.id),
                                  child: const Text("Accept"),
                                ),
                                ElevatedButton(
                                  onPressed: () => startRide(ride.id),
                                  child: const Text("Start"),
                                ),
                                ElevatedButton(
                                  onPressed: () => endRide(ride.id),
                                  child: const Text("End"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
