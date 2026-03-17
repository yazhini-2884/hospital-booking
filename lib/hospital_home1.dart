

import 'package:flutter/material.dart';

class HospitalHome1 extends StatelessWidget {
  const HospitalHome1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to Hospital Booking App",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'inter' ,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,  
      ),
      
      const SizedBox(height: 20),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          "Book your appointments with ease and convenience. Our app allows you to schedule appointments with your preferred healthcare providers, ensuring you get the care you need when you need it.",
          style: TextStyle(
            fontSize: 16, 
            color: Colors.black54
            ),
          textAlign: TextAlign.center,
        ),
        ),
        const SizedBox(height: 20),

        const Text(
          "Notification will be sent once a patient books an appointment",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
          textAlign: TextAlign.center,
        ),
          ]
        ),
      ),

    );
    
  }
}

  