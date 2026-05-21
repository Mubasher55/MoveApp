import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverScreen extends StatelessWidget {

  Future acceptRide(String docId) async {

    await FirebaseFirestore.instance
        .collection("rides")
        .doc(docId)
        .update({

      "status": "accepted",
      
      "driverId": "driver1",

    });

    print("Ride Accepted");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(
        title: Text("Driver Panel"),
        backgroundColor: Colors.orange,
      ),

      body: StreamBuilder(
await FirebaseFirestore.instance
  .collection("rides")
  .doc(rideId)
  .update({
    "status": "completed",
  
  });

        builder: (context, snapshot) {

          if (!snapshot.hasData) {

            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var rides = snapshot.data!.docs;

          return ListView.builder(

            itemCount: rides.length,

            itemBuilder: (context, index) {

              var ride = rides[index];

              return Card(

                color: Colors.grey[900],

                child: ListTile(

                  title: Text(
                    "${ride["pickup"]} → ${ride["drop"]}",
                    style: TextStyle(color: Colors.white),
                  ),

                  subtitle: Text(
                    "Fare: ${ride["fare"]}",
                    style: TextStyle(color: Colors.orange),
                  ),

                  trailing: Column(

  children: [

    ElevatedButton(

      onPressed: () {

        acceptRide(ride.id);

      },

      child: Text("Accept"),
    ),

    ElevatedButton(

      onPressed: () async {

        .collection("rides")
        .where("status", isEqualTo: "pending")

        });

      },

      child: Text("Start"),
    ),

    ElevatedButton(

      onPressed: () async {

        await FirebaseFirestore.instance
            .collection("rides")
            .doc(ride.id)
            .update({

          "status": "completed",
          "paymentStatus": "paid".

        });

      },

      child: Text("End"),
    ),

  ],
),
