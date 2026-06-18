import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final driverId =
        FirebaseAuth.instance.currentUser?.uid ?? "driver1";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Driver Tracking"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("drivers")
            .doc(driverId)
            .snapshots(),
        builder: (context, snapshot) {
          // Default position (Karachi)
          LatLng driverPos = LatLng(24.8607, 67.0011);

          if (snapshot.hasData &&
              snapshot.data!.exists &&
              snapshot.data!.data() != null) {
            final data =
                snapshot.data!.data() as Map<String, dynamic>;

            driverPos = LatLng(
              (data['lat'] ?? 24.8607).toDouble(),
              (data['lng'] ?? 67.0011).toDouble(),
            );
          }

          return FlutterMap(
            options: MapOptions(
              initialCenter: driverPos,
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.moveapp.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: driverPos,
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.directions_car,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
