
import 'package:flutter/material.dart';
import 'package:hospital_booking/hospital_type.dart';

class AlternateContactPage extends StatelessWidget {

  final TextEditingController roleController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  AlternateContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Alternate Contact Details"),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// Role
            TextField(
              controller: roleController,
              decoration: InputDecoration(
                labelText: "Role",
                hintText: "Example: Receptionist / Manager",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            /// Contact Person Name
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Contact Person Name",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            /// Mobile Number
            TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Mobile Number",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 30),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()
                {
                  if(nameController.text.isEmpty || 
                  roleController.text.isEmpty ||
                   mobileController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please fill all the fields"),
                      ),
                    );
                  } 
                  else
                    {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HospitalType
                      (),
                    ),
                  );
                    }
                  print("Role: ${roleController.text}");
                  print("Name: ${nameController.text}");
                  print("Mobile: ${mobileController.text}");
                },
                style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            ),
                child: Text("Save",
                 style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'inter'
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