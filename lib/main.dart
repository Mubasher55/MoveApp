import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'move_home_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoveApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MoveHomeScreen(),
      body: Center(
        Text("Welcome to MoveApp 🚀")),
          child: Image.asset("assets/bg.jpg"),
    );
  }
}