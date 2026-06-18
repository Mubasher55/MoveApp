import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Added for dynamic driver ID

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();

  // Get current user's driver ID (or fallback to "driver1")
  String get _driverId => FirebaseAuth.instance.currentUser?.uid ?? 'driver1';

  Future<void> getUserLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    _mapController.move(
      LatLng(position.latitude, position.longitude),
      15,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Driver Tracking"),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("drivers")
            .doc(_driverId) // ← Now dynamic (uses logged‑in driver)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: CircularProgressIndicator());
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;
          LatLng driverPos = LatLng(
            (data["lat"] ?? 0).toDouble(),
            (data["lng"] ?? 0).toDouble(),
          );

          return Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: driverPos,
                  initialZoom: 15,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.moveapp.app',
                    additionalOptions: const {
                      'attribution': '© OpenStreetMap contributors'
                    },
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: driverPos,
                        width: 70,
                        height: 70,
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: const Duration(milliseconds: 500),
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, -10 * value),
                              child: const Icon(
                                Icons.directions_car,
                                color: Colors.blue,
                                size: 45,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // FAB to go to book ride screen
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/book-ride');
                  },
                  child: const Icon(Icons.add_location),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
