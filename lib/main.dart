import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Import your screens (adjust file names if needed)
import 'book_ride_screen.dart';   // if your file is named that';   // contains BookRideScreen
import 'driver_screen.dart';
import 'map_screen.dart';

// Import Firebase options (must be generated)
import 'firebase_options.dart';      // ← ADD THIS

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with platform-specific options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 🔴 FOR TESTING ONLY – auto-login anonymously
  // Remove this line when you have a proper login screen
  await FirebaseAuth.instance.signInAnonymously();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoveApp',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(), // Start with the home screen
      routes: {
        '/book-ride': (context) => const BookRideScreen(),
        '/driver': (context) => const DriverScreen(),
        '/map': (context) => const MapScreen(),
      },
    );
  }
}

// ---------- Home Screen with Navigation Buttons ----------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoveApp'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/book-ride'),
              icon: const Icon(Icons.book_online),
              label: const Text('Book a Ride'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/driver'),
              icon: const Icon(Icons.directions_car),
              label: const Text('Driver Panel'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/map'),
              icon: const Icon(Icons.map),
              label: const Text('Live Map'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
