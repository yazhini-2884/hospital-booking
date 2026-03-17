
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hospital_booking/certification_upload.dart';

class DoctorRegistration extends StatelessWidget {
  const DoctorRegistration({super.key});

 @override
 Widget build(BuildContext context)
 {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      title: const Text("Doctor Registration",
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
            TextField(
              decoration: InputDecoration(
                labelText: "Doctor Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: "Mobile Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: "Email id",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
             TextField(
              decoration: InputDecoration(
                labelText: "Consultation Fee",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
             TextField(
              decoration: InputDecoration(
                labelText: "Doctor  registration number",
                border: OutlineInputBorder(),
              ),
            ),
             const SizedBox(width: double.infinity, height: 20),
             ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder:(context) => CertificationUploadPage() ,
                  ),
                );
                // Handle button press
              },
             style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            ),
             child: const Text(" Next",
               style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'inter'
               )
             )
        ),
          ],
        ),
      ),
  );
 }
}