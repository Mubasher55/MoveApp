import 'package:flutter/material.dart';

class DeliveryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Delivery"),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [

            buildField("Pickup Address"),
            SizedBox(height: 20),

            buildField("Receiver Address"),
            SizedBox(height: 20),

            buildField("Parcel Details"),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {},

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),

              child: Text("Track Parcel"),
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