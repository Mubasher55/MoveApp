import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RideStatusScreen extends StatelessWidget {
  final String rideId;

  const RideStatusScreen({
    super.key,
    required this.rideId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ride Status"),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("rides")
            .doc(rideId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  "Pickup: ${data["pickup"]}",
                  style: const TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 10),

                Text(
                  "Drop: ${data["drop"]}",
                  style: const TextStyle(fontSize: 18),
                ),

                const SizedBox(height: 30),

                Text(
                  "Status: ${data["status"]}",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
