import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      body: Padding(
        padding: EdgeInsets.all(25),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Icon(
              Icons.local_taxi,
              color: Colors.orange,
              size: 100,
            ),

            SizedBox(height: 20),

            Text(
              "MOVE APP",
              style: TextStyle(
                color: Colors.orange,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 50),

            TextField(
              decoration: InputDecoration(
                hintText: "Email",
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            SizedBox(height: 20),

            TextField(
              obscureText: true,

              decoration: InputDecoration(
                hintText: "Password",
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),

                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },

                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}