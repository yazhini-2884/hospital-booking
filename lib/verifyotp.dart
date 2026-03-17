
import 'package:flutter/material.dart';
import 'package:hospital_booking/registration.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key});
  
  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final List<TextEditingController> otpControllers = List.generate(6, (index) => TextEditingController());

  final List<FocusNode> otpFocusNodes = List.generate(6, (index) => FocusNode());

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("verify OTP",
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
        padding: const EdgeInsets.all(10) ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const SizedBox(height: 40),

           const Text(
              "Enter the 6-digit OTP sent to your mobile number",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'inter'
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 45,
                  height: 45,
                  child: TextField(
                    controller: otpControllers[index],
                    focusNode: otpFocusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                
                   onChanged: (value) {
                    if (value.length == 1 && index < 5) {
                      otpFocusNodes[index + 1].requestFocus();
                    } else if (value.isEmpty && index > 0) {
                      otpFocusNodes[index - 1].requestFocus();
                    }
                  }
                  ),
                );
              }),
            ),
            
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Handle resend OTP logic here
              },
              child: const Text(("Resend OTP"),
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'inter'
              )
              ),
            ),
            const SizedBox(width: double.infinity),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Registration()
                  ),
                );
              },
              style:ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            ),
            
              child: const Text((" Verify OTP "),
               style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'inter'
             )
              ),
            )
          ]
        )
    ),
    );
}
}