import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class DriverLocationService {

  Future<void> startTracking(String driverId) async {

    LocationPermission permission =
        await Geolocator.requestPermission();

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // 10 meters move update
      ),
    ).listen((Position position) async {

      await FirebaseFirestore.instance
          .collection("drivers")
          .doc(driverId)
          .set({
        "latitude": position.latitude,
        "longitude": position.longitude,
        "updatedAt": DateTime.now().toString(),
        "online": true,
      });

    });
  }
}