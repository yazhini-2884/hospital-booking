
import 'package:flutter/material.dart';
import 'package:hospital_booking/hospital_home1.dart';

class HospitalType extends StatefulWidget {
  const HospitalType({super.key});

  @override
  State<HospitalType> createState() => _HospitalTypeState();
}

class _HospitalTypeState extends State<HospitalType> {

  String? selectedHospitalType;
  String? selectedDepartment;

  List<String> hospitalTypes = [
    'Multi-specialty Hospital',
    'Diagnostic Center',
    'General Hospital',
    'Clinic'
  ];

  List<String> departments = [
    'Cardiology',
    'Neurology',
    'Pediatrics',
    'Orthopedics',
    'Dermatology',
    'Gynecology',
    'Oncology',
    'Psychiatry',
    'Urology'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.blue,
          title: Text('Hospital Type',
            style: TextStyle(
              color: const Color(0xFFFFFFFF), // Using a white color value (ARGB: 255, 255, 255, 255)
              fontSize: 24,
              fontFamily: 'inter',
              fontWeight: FontWeight.bold,
              ),
          ),
           centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Hospital Type',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'inter',
                    ),
                    textAlign: TextAlign.left,
                ),

                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    hintText: "Select Hospital Type",
                  ),
                   initialValue: selectedHospitalType,
                  items: hospitalTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedHospitalType = value;
                    });
                  },
                ),

                const SizedBox(height: 20),
                Text(
                  'Select Department',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'inter',
                  ),
                     textAlign: TextAlign.left, 
                  
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    hintText: "Select Department",
                  ),
                   initialValue: selectedDepartment,
                  items: departments.map((dept) {
                    return DropdownMenuItem<String>(
                      value: dept,
                      child: Text(dept),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDepartment = value;
                    });
                  },
                ),  
                SizedBox(height: 40),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HospitalHome1()),
                      );
                      // Handle button press
                    },
                  
              style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            ),
              child: Text('Finish'),
                  ),
                )
              ],
            ),

          )
    );
  }
}