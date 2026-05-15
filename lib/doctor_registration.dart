// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hospital_booking/certification_upload.dart';
import 'package:hospital_booking/hospital_home2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorRegistration extends StatefulWidget {
  const DoctorRegistration({super.key});

  @override
  State<DoctorRegistration> createState() => _DoctorRegistrationState();
}

class _DoctorRegistrationState extends State<DoctorRegistration> {

  final doctorNameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final feeController = TextEditingController();
  final regNoController = TextEditingController();
 
 Future<void> getDoctor() async {
  final prefs = await SharedPreferences.getInstance();
  String? hospitalId = prefs.getString("hospital_id");

  final response = await http.get(
    Uri.parse("http://192.168.29.236:3000/api/doctor/hospital-single/$hospitalId"),
  );

  final data = jsonDecode(response.body);

  if (response.statusCode == 200) {
    print(data["doctor"]["doctor_name"]);
  } else {
    print("No doctor found");
  }
}
  // 🔥 API CALL FUNCTION
   Future<void> registerDoctor() async {

    if (doctorNameController.text.isEmpty ||
        mobileController.text.isEmpty ||
        feeController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fill required fields")),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String? hospitalId = prefs.getString("hospital_id");

    if (hospitalId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Hospital not found")),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("http://192.168.29.236:3000/api/doctor/create"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "hospital_id": hospitalId,
          "doctor_name": doctorNameController.text.trim(),
          "mobile_no": int.parse(mobileController.text.trim()),
          "email": emailController.text.trim(),
          "consultation_fee": int.parse(feeController.text.trim()),
          "doctor_registration_number": regNoController.text.trim(),
        }),
      );

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"])),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HospitalHome2(),
          ),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to register doctor")),
        );
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Doctor Registration",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: 'inter',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextField(
              controller: doctorNameController,
              decoration: const InputDecoration(
                labelText: "Doctor Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Mobile Number",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email id",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: feeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Consultation Fee",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: regNoController,
              decoration: const InputDecoration(
                labelText: "Doctor Registration Number",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: registerDoctor, // 🔥 API CALL
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              ),
              child: const Text(
                "Finish",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}