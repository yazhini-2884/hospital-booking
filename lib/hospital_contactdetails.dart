import 'package:flutter/material.dart';
import 'package:hospital_booking/hospital_type.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HospitalContactDetails extends StatefulWidget {
  const HospitalContactDetails({super.key});

  @override
  State<HospitalContactDetails> createState() => _HospitalContactDetailsState();
}

class _HospitalContactDetailsState extends State<HospitalContactDetails> {

  final TextEditingController hospitalNumberController = TextEditingController();
  final TextEditingController helplineNumberController = TextEditingController();
  



  // 🔥 API FUNCTION
  Future<void> submitContactDetails() async {
    String hospitalNo = hospitalNumberController.text.trim();
    String helplineNo = helplineNumberController.text.trim();

    if (hospitalNo.isEmpty || helplineNo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fill all fields")),
      );
      return;
    }

    try {
      final response = await http.put(
        Uri.parse("http://192.168.29.236:3000/api/hospital/contact-details"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "mobile_no": "987654321", // ✅ DYNAMIC MOBILE
          "hospital_contact_no": hospitalNo,
          "helpline_no": helplineNo,
        }),
      ); 

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"])),
        );

             Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HospitalType(
  
            ),
          ),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update")),
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
        title: Text("Hospital Contact Details",
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
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// Hospital Number
            TextField(
              controller: hospitalNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Hospital Contact Number",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            /// Helpline Number
            TextField(
              controller: helplineNumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Hospital Helpline Number",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 30),

            /// Navigate to Alternate Contact Page
            SizedBox(
              child: ElevatedButton(
                onPressed: () => submitContactDetails(),
                style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            ),
             child: Text("Next", 
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'inter',
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

