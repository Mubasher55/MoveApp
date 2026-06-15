import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;

  static const LatLng initialPosition =
      LatLng(31.5204, 74.3587); // Lahore default

  LatLng currentPosition = initialPosition;

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  Future<void> getUserLocation() async {
    LocationPermission permission =
        await Geolocator.requestPermission();

    Position position =
        await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

    setState(() {
      currentPosition =
          LatLng(position.latitude, position.longitude);
    });

    mapController?.animateCamera(
      CameraUpdate.newLatLng(currentPosition),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location"),
        backgroundColor: Colors.orange,
      ),

      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition: const CameraPosition(
          target: LatLng(31.5204, 74.3587),
          zoom: 14,
        ),

        onMapCreated: (controller) {
          mapController = controller;
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        child: const Icon(Icons.my_location),

        onPressed: () async {
          await getUserLocation();
        },
      ),
    );
  }
}
