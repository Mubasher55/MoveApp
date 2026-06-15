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

      body: FlutterMap(
  options: MapOptions(
    initialCenter: LatLng(31.5204, 74.3587),
    initialZoom: 13,
  ),
  children: [
    TileLayer(
      urlTemplate:
          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    ),
    MarkerLayer(
      markers: [
        Marker(
          point: LatLng(31.5204, 74.3587),
          width: 50,
          height: 50,
          child: const Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 40,
          ),
        ),
      ],
    ),
  ],
),
