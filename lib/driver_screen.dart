import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class DriverScreen extends StatefulWidget {
const DriverScreen({super.key});

@override
State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {

@override
void initState() {
super.initState();
startTracking();
}

void startTracking() {
Geolocator.getPositionStream(
locationSettings: const LocationSettings(
accuracy: LocationAccuracy.high,
distanceFilter: 10,
),
).listen((position) {
FirebaseFirestore.instance
.collection("drivers")
.doc("driver1")
.set({
"lat": position.latitude,
"lng": position.longitude,
});
});
}

Future<void> acceptRide(String rideId) async {
await FirebaseFirestore.instance
.collection("rides")
.doc(rideId)
.update({
"status": "accepted",
"driverId": "driver1",
});
}

Future<void> startRide(String rideId) async {
await FirebaseFirestore.instance
.collection("rides")
.doc(rideId)
.update({
"status": "started",
});
}

Future<void> endRide(String rideId) async {
await FirebaseFirestore.instance
.collection("rides")
.doc(rideId)
.update({
"status": "completed",
"paymentStatus": "paid",
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

  body: StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection("rides")
        .snapshots(),
    builder: (context, snapshot) {

      if (!snapshot.hasData) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      var rides = snapshot.data!.docs;

      if (rides.isEmpty) {
        return const Center(
          child: Text(
            "No Rides Found",
            style: TextStyle(color: Colors.white),
          ),
        );
      }

      return ListView.builder(
        itemCount: rides.length,
        itemBuilder: (context, index) {

          var ride = rides[index];

          return Card(
            color: Colors.grey[900],
            child: Padding(
              padding: const EdgeInsets.all(12),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    "${ride["pickup"]} → ${ride["drop"]}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Fare: ${ride["fare"]}",
                    style: const TextStyle(
                      color: Colors.orange,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Status: ${ride["status"]}",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 10,
                    children: [

                      if (ride["status"] == "pending")
                        ElevatedButton(
                          onPressed: () {
                            acceptRide(ride.id);
                          },
                          child: const Text("Accept"),
                        ),

                      if (ride["status"] == "accepted")
                        ElevatedButton(
                          onPressed: () {
                            startRide(ride.id);
                          },
                          child: const Text("Start"),
                        ),

                      if (ride["status"] == "started")
                        ElevatedButton(
                          onPressed: () {
                            endRide(ride.id);
                          },
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
);

}
}
