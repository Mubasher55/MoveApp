import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RideListScreen extends StatelessWidget {
  const RideListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Rides")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("rides").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index];

              return ListTile(
                title: Text(data["pickup"]),
                subtitle: Text(data["drop"]),
                trailing: Text(data["fare"]),
              );
            },
          );
        },
      ),
    );
  }
}
