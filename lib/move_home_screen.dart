import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MoveHomeScreen(),
    ),
  );
}

class MoveHomeScreen extends StatelessWidget {
  const MoveHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),

        child: SafeArea(

          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children:  [

                    Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 30,
                    ),

                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,

                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                const Text(
                  "MOVE APP",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 38,
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

                const SizedBox(height: 40),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),

                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),

                    borderRadius:
                        BorderRadius.circular(24),
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children:  [

                      Text(
                        "Wallet Balance",

                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
  "Rs 18,500",
  style: TextStyle(
    color: Colors.white,
    fontSize: 34,
    fontWeight: FontWeight.bold,
  ),
),

SizedBox(height: 30),

SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {},
    child: Text("🚕 Book Ride"),
  ),
),

SizedBox(height: 15),

SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {},
    child: Text("📦 Delivery"),
  ),
),

SizedBox(height: 15),

SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {},
    child: Text("🚚 Cargo"),
  ),
),

SizedBox(height: 15),

SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {},
    child: Text("💰 Wallet"),
  ),
),
],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
