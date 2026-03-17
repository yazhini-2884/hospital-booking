

import 'package:flutter/material.dart';
import 'package:hospital_booking/doctor_registration.dart';
import 'package:hospital_booking/hospital_registration.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context)
{
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      title: const Text("Registration",
        style: 
          TextStyle(
              color:  Color(0xFFFFFFFF), // Using a white color value (ARGB: 255, 255, 255, 255)
              fontSize: 24,
              fontFamily: '',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
       body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            GestureDetector(
               onTap:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder:(context) => DoctorRegistration() ,
                  ),
                );
               } ,
               child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text( " Doctor Registration",
                    textAlign: TextAlign.center,
                    style:TextStyle( 
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    ),
                    ),
                    ),
                  ),
            ),
            const SizedBox(height: 40),

        GestureDetector(
               onTap:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder:(context) => HospitalRegistration() ,
                  ),
                );
               } ,
               child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text( " Hospital Registration",
                    textAlign: TextAlign.center,
                    style:TextStyle( 
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    ),
                    ),
                    ),
                  ),
            ),         
          ],
        ),
       )
      );
}
}
