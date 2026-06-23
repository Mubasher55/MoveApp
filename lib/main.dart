import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';
import 'login_screen.dart';
import 'move_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Firebase Init Error: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Move App',

      // 👇 SAFE ROUTER (NO BLACK SCREEN)
      home: const AuthGate(),

      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
    );
  }
}

/// ✅ AUTH GATE (FINAL SAFE VERSION)
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        // 🔵 Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 🔴 Error
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text(
                "Something went wrong",
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        // 🟢 Logged in
        if (snapshot.hasData) {
          return const MoveHomeScreen();
        }

        // 🟡 Not logged in
        return const LoginScreen();
      },
    );
  }
}
