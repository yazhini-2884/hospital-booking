import 'package:flutter/material.dart';
import 'package:hospital_booking/hospital_type.dart';


class HospitalContactDetails extends StatelessWidget {

  final TextEditingController hospitalNumberController = TextEditingController();
  final TextEditingController helplineNumberController = TextEditingController();

  HospitalContactDetails({super.key});

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
              //width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HospitalType(),
                    ),
                  );

                },
              style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            ),
             child: Text("Next", 
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'inter',
             )
             )
            ),
            ),
            ],
        ),
      ),
    );
  }
}

