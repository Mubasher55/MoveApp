import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RideStatusScreen extends StatelessWidget {
  final String rideId;

  const RideStatusScreen({
    super.key,
    required this.rideId,
  });

  Color getStatusColor(String status) {
    switch (status) {
      case "pending":
        return Colors.orange;
      case "accepted":
        return Colors.blue;
      case "started":
        return Colors.green;
      case "completed":
        return Colors.grey;
      default:
        return Colors.orange;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case "pending":
        return Icons.search;
      case "accepted":
        return Icons.local_taxi;
      case "started":
        return Icons.directions_car;
      case "completed":
        return Icons.check_circle;
      default:
        return Icons.search;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case "pending":
        return "Searching Driver...";
      case "accepted":
        return "Driver Accepted";
      case "started":
        return "Ride Started";
      case "completed":
        return "Ride Completed";
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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

          if (!snapshot.data!.exists) {
            return const Center(
              child: Text(
                "Ride Not Found",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final data =
              snapshot.data!.data() as Map<String, dynamic>;

          final status = data["status"] ?? "pending";

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                const SizedBox(height: 20),

                CircleAvatar(
                  radius: 45,
                  backgroundColor: getStatusColor(status),
                  child: Icon(
                    getStatusIcon(status),
                    color: Colors.white,
                    size: 45,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  getStatusText(status),
                  style: TextStyle(
                    color: getStatusColor(status),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                Card(
                  color: Colors.grey.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [

                        ListTile(
                          leading: const Icon(
                            Icons.location_on,
                            color: Colors.green,
                          ),
                          title: Text(
                            data["pickup"] ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const Divider(),

                        ListTile(
                          leading: const Icon(
                            Icons.flag,
                            color: Colors.red,
                          ),
                          title: Text(
                            data["drop"] ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const Divider(),

                        ListTile(
                          leading: const Icon(
                            Icons.money,
                            color: Colors.orange,
                          ),
                          title: Text(
                            "PKR ${data["fare"]}",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text("Refresh"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: const Size(double.infinity, 55),
                    ),
                    onPressed: () {},
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
