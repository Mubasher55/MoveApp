import 'package:flutter/material.dart';
import 'ride_booking.dart';

class RideSelectionScreen extends StatelessWidget {
  const RideSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Choose Ride"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          RideTile(
            icon: Icons.local_taxi,
            title: "MOVE Economy",
            time: "2 min",
            price: "PKR 450",
          ),
          RideTile(
            icon: Icons.directions_car,
            title: "MOVE Comfort",
            time: "4 min",
            price: "PKR 650",
          ),
          RideTile(
            icon: Icons.airport_shuttle,
            title: "MOVE XL",
            time: "6 min",
            price: "PKR 950",
          ),
          RideTile(
            icon: Icons.two_wheeler,
            title: "Bike",
            time: "1 min",
            price: "PKR 180",
          ),
        ],
      ),
    );
  }
}

class RideTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;
  final String price;

  const RideTile({
    super.key,
    required this.icon,
    required this.title,
    required this.time,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const BookRideScreen(),
            ),
          );
        },
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.orange,
            size: 35,
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "$time away",
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
          trailing: Text(
            price,
            style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
