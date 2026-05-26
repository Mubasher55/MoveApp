StreamBuilder(
  stream: FirebaseFirestore.instance
      .collection("rides")
      .snapshots(),

  builder: (context, snapshot) {

    var rides = snapshot.data!.docs;

    return ListView.builder(
      itemCount: rides.length,
      itemBuilder: (context, index) {

        var ride = rides[index];

        return ListTile(
          title: Text(ride["pickup"]),
          subtitle: Text("Status: ${ride["status"]}"),
        );
      },
    );
  },
);