import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {

  @override
  State<PaymentScreen> createState() =>
      _PaymentScreenState();
}

class _PaymentScreenState
    extends State<PaymentScreen> {

  String selectedPayment = "Cash";

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(
        title: Text("Payment"),
        backgroundColor: Colors.orange,
      ),

      body: Padding(

        padding: EdgeInsets.all(20),

        child: Column(

          children: [

            ListTile(

              title: Text(
                "Cash",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),

              leading: Radio(

                value: "Cash",

                groupValue:
                    selectedPayment,

                onChanged: (value) {

                  setState(() {

                    selectedPayment =
                        value.toString();
                  });
                },
              ),
            ),

            ListTile(

              title: Text(
                "JazzCash",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),

              leading: Radio(

                value: "JazzCash",

                groupValue:
                    selectedPayment,

                onChanged: (value) {

                  setState(() {

                    selectedPayment =
                        value.toString();
                  });
                },
              ),
            ),

            ListTile(

              title: Text(
                "EasyPaisa",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),

              leading: Radio(

                value: "EasyPaisa",

                groupValue:
                    selectedPayment,

                onChanged: (value) {

                  setState(() {

                    selectedPayment =
                        value.toString();
                  });
                },
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(

  onPressed: () async {

      await FirebaseFirestore.instance
      .collection("rides")
      .doc("CURRENT_RIDE_ID")
      .update({

    "paymentMethod": selectedPayment,
    "paymentStatus": "pending",

  });

  ScaffoldMessenger.of(context)
      .showSnackBar(
    SnackBar(
      content: Text(
        "Payment Saved: $selectedPayment",
      ),
    ),
  );
}

              child: Text("Confirm Payment"),
            ),

          ],
        ),
      ),
    );
  }
}