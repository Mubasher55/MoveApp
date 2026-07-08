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

          SizedBox(height: 12),

          RideTile(
            icon: Icons.directions_car,
            title: "MOVE Comfort",
            time: "4 min",
            price: "PKR 650",
          ),

          SizedBox(height: 12),

          RideTile(
            icon: Icons.airport_shuttle,
            title: "MOVE XL",
            time: "6 min",
            price: "PKR 950",
          ),

          SizedBox(height: 12),

          RideTile(
            icon: Icons.two_wheeler,
            title: "MOVE Bike",
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),

      child: InkWell(
        borderRadius: BorderRadius.circular(15),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const BookRideScreen(),
            ),
          );
        },

        child: Padding(
          padding: const EdgeInsets.all(12),

          child: Row(
            children: [

              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.orange,
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      "$time away",
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                price,
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
