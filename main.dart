import 'package:flutter/material.dart';

import 'login_screen.dart';

void main() {
  runApp(MoveApp());
}

class MoveApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}