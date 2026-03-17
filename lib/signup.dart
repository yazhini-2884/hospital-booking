import 'package:flutter/material.dart';
import 'package:hospital_booking/verifyotp.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Signup",
        style: 
          TextStyle(
              color:  Color(0xFFFFFFFF), // Using a white color value (ARGB: 255, 255, 255, 255)
              fontSize: 24,
              fontFamily: 'inter',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.all(20) ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: " Mobile Number",
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VerifyOtp()),
                );
              },
              style:ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            ),
            
              child: const Text((" Send OTP " ),
               style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'inter'
             )
              ),
        ),
          ],
        )
        )
    );
  }
}



