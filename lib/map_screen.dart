import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Map")),
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
                    width: 60,
                    height: 60,
                    child: const Icon(
                      Icons.directions_car,
                      color: Colors.blue,
                      size: 40,
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

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: getUserLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
