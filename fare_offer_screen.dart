import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FareOfferScreen extends StatefulWidget {

  @override
  State<FareOfferScreen> createState() =>
      _FareOfferScreenState();
}

class _FareOfferScreenState
    extends State<FareOfferScreen> {

  TextEditingController offer =
      TextEditingController();

  Future sendOffer() async {

    await FirebaseFirestore.instance
        .collection("offers")
        .add({

      "offer": int.parse(offer.text),
      "status": "pending",

    });

    print("Offer Sent");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(
        title: Text("Fare Offer"),
        backgroundColor: Colors.orange,
      ),

      body: Padding(

        padding: EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: offer,
              keyboardType: TextInputType.number,

              style: TextStyle(
                color: Colors.white,
              ),

              decoration: InputDecoration(
                hintText: "Enter Fare Offer",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: sendOffer,
              child: Text("SEND OFFER"),
            ),

          ],
        ),
      ),
    );
  }
}