import 'package:flutter/material.dart';

class TaxiScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Taxi Booking"),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [

            buildField("Pickup Location"),
            SizedBox(height: 20),

            buildField("Drop Location"),
            SizedBox(height: 20),

            buildField("Offer Fare"),

            SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),

              onPressed: () {},

              child: Text(
                "Find Driver",
                style: TextStyle(color: Colors.black),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildField(String hint) {

    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}