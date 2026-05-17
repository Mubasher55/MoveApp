import 'package:flutter/material.dart';

class DriverScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Driver Panel"),
      ),

      body: Center(
        child: Text(
          "Driver Online",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}