import 'package:flutter/material.dart';
import 'package:hospital_booking/verifyotp.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final TextEditingController mobileController = TextEditingController();

  // 🔥 Send OTP API Call
  Future<void> sendOtp() async {
    String mobile = mobileController.text.trim();

    if (mobile.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter mobile number")),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("http://192.168.29.236:3000/api/otp/send-otp"), // 🔥 change if needed
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "mobile_no": mobile
        }),
      );
     print("Status Code: ${response.statusCode}");
     print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final prefs = await SharedPreferences.getInstance();
        if (data["hospital_id"] != null) {
          prefs.setString("hospital_id", data["hospital_id"].toString());
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "OTP sent successfully")),
        );

        // ✅ Navigate to OTP page with mobile number
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyOtp(mobileNo: mobile),
          ),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send OTP")),
        );
      }

    } catch(e) {
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
            TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: " Mobile Number",
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                sendOtp();
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



