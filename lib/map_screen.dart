import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();

  Future<void> getUserLocation() async {
    // Check location permissions and get current position
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Animate map to user's location
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
            .doc("driver1")
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
                    urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
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
              // FAB overlay
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  onPressed: getUserLocation,
                  child: const Icon(Icons.my_location),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
