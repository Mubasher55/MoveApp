import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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

      // ❌ Navigator NOT needed (StreamBuilder will auto move screen)

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "MOVE APP LOGIN",
              style: TextStyle(color: Colors.orange, fontSize: 28),
            ),
            const SizedBox(height: 30),

            TextField(
              controller: email,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: password,
              obscureText: true,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: login,
              child: const Text("LOGIN"),
            ),
          ],
        ),
      ),
    );
  }
}
