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
        return "Searching Driver";
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
        backgroundColor: Colors.orange,
        title: const Text("Ride Status"),
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

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final status = data["status"] ?? "pending";

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                const SizedBox(height: 20),

                CircleAvatar(
                  radius: 50,
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
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                Card(
                  color: Colors.grey.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [

                        ListTile(
                          leading: const Icon(
                            Icons.my_location,
                            color: Colors.green,
                          ),
                          title: Text(
                            data["pickup"] ?? "",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),

                        const Divider(),

                        ListTile(
                          leading: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                          ),
                          title: Text(
                            data["drop"] ?? "",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),

                        const Divider(),

                        ListTile(
                          leading: const Icon(
                            Icons.payments,
                            color: Colors.orange,
                          ),
                          title: Text(
                            "PKR ${data["fare"]}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Card(
                  color: Colors.grey.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [

                        const CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.orange,
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Text(
                          data["driver"] == null ||
                                  data["driver"].toString().isEmpty
                              ? "Searching Driver..."
                              : data["driver"],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Car Type: ${data["carType"] ?? "Car"}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(double.infinity, 55),
                        ),
                        onPressed: () {
                          // TODO: Call Driver
                        },
                        icon: const Icon(Icons.call),
                        label: const Text("Call"),
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(double.infinity, 55),
                        ),
                        onPressed: () {
                          // TODO: Open Chat
                        },
                        icon: const Icon(Icons.chat),
                        label: const Text("Chat"),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size(double.infinity, 55),
                    ),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection("rides")
                          .doc(rideId)
                          .delete();

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text("Cancel Ride"),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: const Size(double.infinity, 55),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.refresh),
                    label: const Text("Refresh"),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
