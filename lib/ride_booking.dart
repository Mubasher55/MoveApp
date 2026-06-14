import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ride_status_screen.dart';

class RideBookingScreen extends StatefulWidget {
  const RideBookingScreen({super.key});

  @override
  State<RideBookingScreen> createState() =>
      _RideBookingScreenState();
}

class _RideBookingScreenState
    extends State<RideBookingScreen> {

  TextEditingController pickup = TextEditingController();
  TextEditingController drop = TextEditingController();
  TextEditingController fare = TextEditingController();

  Future<String> bookRide() async {

  DocumentReference docRef =
      await FirebaseFirestore.instance
          .collection("rides")
          .add({

    "pickup": pickup.text,
    "drop": drop.text,
    "fare": fare.text,
    "status": "pending",
    "driverId": "",
    "createdAt": DateTime.now().toString(),
  });

  return docRef.id;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(
        title: const Text("Book Ride"),
        backgroundColor: Colors.orange,
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: pickup,
              style: const TextStyle(color: Colors.white),

              decoration: const InputDecoration(
                hintText: "Pickup Location",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: drop,
              style: const TextStyle(color: Colors.white),

              decoration: const InputDecoration(
                hintText: "Drop Location",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: fare,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),

              decoration: const InputDecoration(
                hintText: "Fare Offer",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 30),

  ElevatedButton(
  onPressed: () async {
  try {

    String rideId = await bookRide();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            RideStatusScreen(
          rideId: rideId,
        ),
      ),
    );

  } catch (e) {

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(e.toString()),
      ),
    );
  }
},

          ],
        ),
      ),
    );
  }
}
