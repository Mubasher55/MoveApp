import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RideBookingScreen extends StatefulWidget {

  @override
  State<RideBookingScreen> createState() =>
      _RideBookingScreenState();
}

class _RideBookingScreenState
    extends State<RideBookingScreen> {

  TextEditingController pickup = TextEditingController();
  TextEditingController drop = TextEditingController();
  TextEditingController fare = TextEditingController();

  Future bookRide() async {

await FirebaseFirestore.instance
    .collection("rides")
    .add({

  "pickup": pickupController.text,
  "drop": dropController.text,
  "fare": fare,

  "status": "pending",

  // 🚖 AUTO ASSIGN
  "driverId": "",

  "createdAt":
      DateTime.now().toString(),

});

    print("Ride Booked");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(
        title: Text("Book Ride"),
        backgroundColor: Colors.orange,
      ),

      body: Padding(

        padding: EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: pickup,
              style: TextStyle(color: Colors.white),

              decoration: InputDecoration(
                hintText: "Pickup Location",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: drop,
              style: TextStyle(color: Colors.white),

              decoration: InputDecoration(
                hintText: "Drop Location",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: fare,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),

              decoration: InputDecoration(
                hintText: "Fare Offer",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed:book ride,
              sendRideNotification();

              child: Text("BOOK RIDE"),
            ),

          ],
        ),
      ),
    );
  }
}