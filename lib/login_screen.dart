import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future login() async {

    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      print("Login Success");

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
              "MOVE APP LOGIN",
              style: TextStyle(
                color: Colors.orange,
                fontSize: 28,
              ),
            ),

            SizedBox(height: 30),

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
              onPressed: login,
              child: Text("LOGIN"),
            ),

          ],
        ),
      ),
    );
  }
}