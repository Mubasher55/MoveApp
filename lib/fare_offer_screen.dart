import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FareOfferScreen extends StatefulWidget {
  final String rideId;

  const FareOfferScreen({
    super.key,
    required this.rideId,
  });

  @override
  State<FareOfferScreen> createState() => _FareOfferScreenState();
}

class _FareOfferScreenState extends State<FareOfferScreen> {
  final TextEditingController fareController = TextEditingController();

  bool loading = false;

  Future<void> sendOffer() async {
    if (fareController.text.isEmpty) return;

    setState(() {
      loading = true;
    });

    await FirebaseFirestore.instance
        .collection("rides")
        .doc(widget.rideId)
        .update({
      "fare": double.parse(fareController.text),
      "status": "offer_sent",
    });

    setState(() {
      loading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Fare Offer Sent"),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Offer Your Fare"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            const SizedBox(height: 30),

            const Icon(
              Icons.local_taxi,
              color: Colors.orange,
              size: 80,
            ),

            const SizedBox(height: 20),

            const Text(
              "Choose Your Fare",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: fareController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter Fare (PKR)",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey.shade900,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : sendOffer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 55),
                ),
                child: loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "SEND OFFER",
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
