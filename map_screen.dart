import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Google Maps"),
      ),

      body: Center(
        child: Icon(
          Icons.map,
          size: 150,
          color: Colors.orange,
        ),
      ),
    );
  }
}