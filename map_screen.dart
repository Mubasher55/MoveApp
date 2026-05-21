import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  double driverLat = 31.5204;
  double driverLng = 74.3587;

  LatLng currentLocation =
      LatLng(31.5204, 74.3587);

  GoogleMapController? mapController;

  LatLng currentLocation =
      LatLng(31.5204, 74.3587);

  @override
  void initState() {

    super.initState();

    getLocation();
 
    startLiveTracking();
  }

  Future getLocation() async {

    LocationPermission permission =
    await Geolocator.requestPermission();

    Position position =
    await Geolocator.getCurrentPosition();

    setState(() {

      currentLocation =
          LatLng(position.latitude,
              position.longitude);

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("MoveApp Live Map"),
        backgroundColor: Colors.orange,
      ),

      body: GoogleMap(

        initialCameraPosition: CameraPosition(
          target: currentLocation,
          zoom: 14,
        ),

        onMapCreated: (controller) {

          mapController = controller;
        },

        markers: { 
          Marker(
            markerId: MarkerId("const"),
            position: currentLocation,
          ),Marker(
  markerId: MarkerId("driver"),
  position: LatLng(driverLat, driverLng)
    currentLocation.latitude + 0.002,
    currentLocation.longitude + 0.002,
  ),
),

StreamBuilder(
  stream: FirebaseFirestore.instance
      .collection("drivers")
      .doc("driver1")
      .snapshots(),

  builder: (context, snapshot) {

    if (!snapshot.hasData) {
      return CircularProgressIndicator();
    }

    var data = snapshot.data!;

    return Marker(
      markerId: MarkerId("driver"),
      position: LatLng(
        data["latitude"],
        data["longitude"],
      ),
    );
  },
)