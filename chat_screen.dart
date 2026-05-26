import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {

  @override
  State<ChatScreen> createState() =>
      _ChatScreenState();
}

class _ChatScreenState
    extends State<ChatScreen> {

  TextEditingController message =
      TextEditingController();

  Future sendMessage() async {

    await FirebaseFirestore.instance
        .collection("messages")
        .add({

      "text": message.text.trim(),
      "time": DateTime.now(),

    });

    message.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(
        title: Text("MoveApp Chat"),
        backgroundColor: Colors.orange,
      ),

      body: Column(

        children: [

          Expanded(

            child: StreamBuilder(

              stream: FirebaseFirestore.instance
                  .collection("messages")
                  .orderBy("time")
                  .snapshots(),

              builder: (context, snapshot) {

                if (!snapshot.hasData) {

                  return Center(
                    child:
                    CircularProgressIndicator(),
                  );
                }

                var messages =
                snapshot.data!.docs;

                return ListView.builder(

                  itemCount: messages.length,

                  itemBuilder: (context, index) {

                    var msg = messages[index];

                    return ListTile(

                      title: Text(
                        msg["text"],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Padding(

            padding: EdgeInsets.all(10),

            child: Row(

              children: [

                Expanded(

                  child: TextField(

                    controller: message,

                    style: TextStyle(
                      color: Colors.white,
                    ),

                    decoration: InputDecoration(
                      hintText: "Message...",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),

                IconButton(

                  onPressed: sendMessage,

                  icon: Icon(
                    Icons.send,
                    color: Colors.orange,
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}