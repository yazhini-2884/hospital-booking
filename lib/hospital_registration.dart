
import 'package:flutter/material.dart';
import 'package:hospital_booking/address_model.dart';
import 'package:hospital_booking/hospital_contactdetails.dart';
import 'package:hospital_booking/hospital_location.dart';

class HospitalRegistration extends StatefulWidget {
  const HospitalRegistration({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HospitalRegistrationState createState() => _HospitalRegistrationState();
}

class _HospitalRegistrationState extends State<HospitalRegistration> {
    final hospitalNameController = TextEditingController();
    final registerNumberController = TextEditingController();
    final emailController = TextEditingController();

     Addressmodel? hospitalAddress;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Hospital Registration",
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
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Hospital Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: "Register Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              decoration:  InputDecoration(
                labelText: "Email id",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HospitalLocationScreen()),
                  );

                  if (result != null) {
                    setState(() {
                      hospitalAddress = result;
                    });
                  }
                  
                },
               style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text('Permenant hospital address'),
              ),
            ),

            const SizedBox(height: 20),

            if (hospitalAddress != null) 
                Container(
                 width: MediaQuery.of(context).size.width,
                 padding: const EdgeInsets.all(15),
                 margin: const EdgeInsets.only(top: 15),
                 decoration: BoxDecoration(
                 color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [

        Row(
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.red,
              size: 30,
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                "${hospitalAddress!.houseNumber}, ${hospitalAddress!.street}, ${hospitalAddress!.landmark}, ${hospitalAddress!.pincode}, ${hospitalAddress!.city}, ${hospitalAddress!.state}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),

            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HospitalLocationScreen()),
                );

                if (result != null) {
                  setState(() {
                    hospitalAddress = result;
                  });
                }
              },
            ),
          ],
        ),

        const SizedBox(height: 30),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HospitalContactDetails()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            child: const Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),

      ],
    ),
  ),


   
  ],
        ),
    ), );
  }
}