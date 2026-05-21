import 'package:flutter/material.dart';

class CargoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Cargo Truck"),
      ),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [

            buildField("Pickup City"),
            SizedBox(height: 20),

            buildField("Destination City"),
            SizedBox(height: 20),

            buildField("Load Weight"),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {},

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),

              child: Text("Find Truck"),
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