import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupScreen extends StatefulWidget {

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future signup() async {

    try {

      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection("users").doc(uid).set({

        "name": name.text.trim(),
        "email": email.text.trim(),
        "role": "user",

      });

      print("Signup Success");

    } catch (e) {

      print(e);

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black,

      body: Padding(

        padding: EdgeInsets.all(20),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Text(
              "MOVE APP SIGNUP",
              style: TextStyle(
                color: Colors.orange,
                fontSize: 28,
              ),
            ),

            SizedBox(height: 30),

            TextField(
              controller: name,
              style: TextStyle(color: Colors.white),

              decoration: InputDecoration(
                hintText: "Name",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: email,
              style: TextStyle(color: Colors.white),

              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: password,
              obscureText: true,
              style: TextStyle(color: Colors.white),

              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: signup,
              child: Text("SIGNUP"),
            ),

          ],
        ),
      ),
    );
  }
}