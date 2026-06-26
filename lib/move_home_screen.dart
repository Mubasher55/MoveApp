import 'package:flutter/material.dart';
import 'ride_booking.dart';
import 'map_screen.dart';
import 'driver_screen.dart';
import 'wallet_screen.dart';

class MoveHomeScreen extends StatelessWidget {
  const MoveHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("MOVE APP"),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 20),

              const Text(
                "MOVE APP",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Ride • Delivery • Wallet",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [

                    const Text(
                      "Wallet Balance",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "PKR 18,500",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const BookRideScreen(),
                            ),
                          );
                        },
                        child: const Text("🚕 Book Ride"),
                      ),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MapScreen(),
                            ),
                          );
                        },
                        child: const Text("🗺️ Open Map"),
                      ),
                    ),

                    const SizedBox(height: 15),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DriverScreen(),
                            ),
                          );
                        },
                        child: const Text("🚖 Driver Panel"),
                      ),
                    ),
                    const SizedBox(height: 30),
const Align(
  alignment: Alignment.centerLeft,
  child: Text(
    "Services",
    style: TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
),

const SizedBox(height: 15),

GridView.count(
  crossAxisCount: 2,
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  crossAxisSpacing: 15,
  mainAxisSpacing: 15,
  childAspectRatio: 1.2,
  children: [

    serviceCard(
      context,
      Icons.local_taxi,
      "Taxi",
      Colors.orange,
      const BookRideScreen(),
    ),

    serviceCard(
      context,
      Icons.map,
      "Map",
      Colors.blue,
      const MapScreen(),
    ),

    serviceCard(
      context,
      Icons.person,
      "Driver",
      Colors.red,
      const DriverScreen(),
    ),

    serviceCard(
      context,
      Icons.account_balance_wallet,
      "Wallet",
      Colors.green,
      const WalletScreen(),
    ),
  ],
),
                    Widget serviceCard(
  BuildContext context,
  IconData icon,
  String title,
  Color color,
  Widget page,
) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => page),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 42,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
                    }
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
