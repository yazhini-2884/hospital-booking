
import 'package:flutter/material.dart';
import 'package:hospital_booking/hospital_manage_appointment.dart';
class HospitalHome2 extends StatelessWidget {
  const HospitalHome2({super.key});

  Widget patientcard(BuildContext context){
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HospitalManageAppointment()),
        );
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:const  [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/patient1.jpg'),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Patient Name",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Appointment Time",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
    ),
    ),
);
  }
@override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Appointment",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontFamily: 'inter',
          fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text(
              "Today's Appointments",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            patientcard(context),
            patientcard(context),
            patientcard(context),

            const SizedBox(height: 20),
            const Text(
              "Yesterday's Appointments",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
            patientcard(context),
            patientcard(context),    
          ],
        ),
      ),
    );
  }
}