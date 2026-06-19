import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';
import 'move_home_screen.dart';
import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Move App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
      home: const SplashRouter(),
    );
  }
}

/// ✅ SAFE ROUTER (FIX BLACK SCREEN ISSUE)
class SplashRouter extends StatelessWidget {
  const SplashRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        // 🔵 LOADING SCREEN (IMPORTANT)
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 🔴 ERROR SAFE CHECK
        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text("Something went wrong"),
            ),
          );
        }

        // 🟢 LOGGED IN
        if (snapshot.hasData) {
          return const MoveHomeScreen();
        }

        // 🟡 NOT LOGGED IN
        return const LoginScreen();
      },
    );
  }
}
