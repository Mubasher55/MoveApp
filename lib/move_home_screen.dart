import 'package:flutter/material.dart';
import 'ride_booking.dart';
import 'wallet_screen.dart';
import 'driver_screen.dart';
import 'map_screen.dart';

class MoveHomeScreen extends StatelessWidget {
  const MoveHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "MOVE APP",
          style: TextStyle(
            color: Colors.orange,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        leading: const Icon(Icons.menu, color: Colors.white),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.white),
          SizedBox(width: 10),
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.orange,
            child: Icon(Icons.person, color: Colors.white),
          ),
          SizedBox(width: 10),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Where do you want to go?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [

                    TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.my_location,
                          color: Colors.green,
                        ),
                        hintText: "Pickup Location",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.black54,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        hintText: "Drop Location",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.black54,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const BookRideScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "BOOK RIDE",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Nearby Drivers",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),
              driverCard("Asher", "4.8", "2 min away"),
              const SizedBox(height: 12),

              driverCard("Ahmed", "4.9", "1 min away"),
              const SizedBox(height: 12),

              driverCard("Ali", "4.7", "4 min away"),

              const SizedBox(height: 30),

              Row(
                children: [

                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: const Size(0, 55),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MapScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.map),
                      label: const Text("Map"),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(0, 55),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const WalletScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.account_balance_wallet),
                      label: const Text("Wallet"),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(0, 55),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DriverScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.local_taxi),
                      label: const Text("Driver"),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 30),

              const Text(
                "Special Offers",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "20% OFF",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      "Use code MOVE20 on your next ride",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),

                  ],
                ),
              ),

              const SizedBox(height: 30),
                            const Text(
                "Recent Activity",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Card(
                color: Colors.grey.shade900,
                child: const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange,
                    child: Icon(
                      Icons.local_taxi,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    "Johar → Gulshan",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "PKR 650",
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Card(
                color: Colors.grey.shade900,
                child: const ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.delivery_dining,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    "Food Delivery",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "PKR 280",
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ),
              ),

              const SizedBox(height: 30),

            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.local_taxi),
            label: "Rides",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: "Wallet",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),

        ],
        onTap: (index) {

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const BookRideScreen(),
              ),
            );
          }

          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const WalletScreen(),
              ),
            );
          }

        },
      ),
    );
  }
}
