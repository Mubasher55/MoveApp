import 'package:flutter/material.dart';

import 'taxi_screen.dart';
import 'delivery_screen.dart';
import 'cargo_screen.dart';
import 'driver_screen.dart';
import 'map_screen.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("MOVE APP"),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: ListView(

          children: [

            buildCard(
              context,
              "🚖 Taxi Booking",
              TaxiScreen(),
            ),

            buildCard(
              context,
              "🛵 Delivery",
              DeliveryScreen(),
            ),

            buildCard(
              context,
              "🚚 Cargo Truck",
              CargoScreen(),
            ),

            buildCard(
              context,
              "👨 Driver Panel",
              DriverScreen(),
            ),

            buildCard(
              context,
              "🗺 Google Maps",
              MapScreen(),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildCard(
    BuildContext context,
    String title,
    Widget screen,
  ) {

    return Card(
      color: Colors.grey[900],

      child: ListTile(

        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),

        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),

        onTap: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => screen,
            ),
          );
        },
      ),
    );
  }
}