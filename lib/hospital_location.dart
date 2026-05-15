

import 'package:flutter/material.dart';
import 'package:hospital_booking/address_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HospitalLocationScreen extends StatefulWidget {
  const HospitalLocationScreen({super.key});

  @override
   // ignore: library_private_types_in_public_api
   _HospitalLocationScreenState createState() => _HospitalLocationScreenState();
}
class _HospitalLocationScreenState extends State<HospitalLocationScreen>{

  final nameController = TextEditingController();
  final houseController = TextEditingController(); 
  final streetController = TextEditingController();
  final landmarkController = TextEditingController();
  final pincodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();  

// 🔥 API FUNCTION (NO MOBILE)
  Future<void> saveAddress() async {

    // ✅ GET hospital_id from local storage
    final prefs = await SharedPreferences.getInstance();
    int? hospitalId = prefs.getInt("hospital_id");

    if (hospitalId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in")),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("http://192.168.29.236:3000/api/hospital/update-address"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "hospital_id": hospitalId, // ✅ USE ID
          "house_number": houseController.text.trim(),
          "street": streetController.text.trim(),
          "landmark": landmarkController.text.trim(),
          "pincode": pincodeController.text.trim(),
          "city": cityController.text.trim(),
          "state": stateController.text.trim(),
        }),
      );
      

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"])),
        );

        Addressmodel addressmodel = Addressmodel(
          houseNumber: houseController.text,
          street: streetController.text,
          landmark: landmarkController.text,
          pincode: pincodeController.text,
          city: cityController.text,
          state: stateController.text,
        );

        Navigator.pop(context, addressmodel);

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed")),
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
          'Hospital Location',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),  
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              /// Hospital Name
              //TextField(
                //controller: nameController,
                //decoration: const InputDecoration(
                  //labelText: 'Hospital Name',
                  //border: OutlineInputBorder(),
                //),
              //),

              //const SizedBox(height: 20),

              /// House Number
              TextField(
                controller: houseController,
                decoration: const InputDecoration(
                  labelText: 'Door Number',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              /// Street
              TextField(
                controller: streetController,
                decoration: const InputDecoration(
                  labelText: 'Street',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              /// Landmark
              TextField(
                controller: landmarkController,
                decoration: const InputDecoration(
                  labelText: 'Landmark',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              /// Pincode
              TextField(
                controller: pincodeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Pincode',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              /// City
              TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              /// State
              TextField(
                controller: stateController,
                decoration: const InputDecoration(
                  labelText: 'State',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Addressmodel addressmodel = Addressmodel(
                      houseNumber: houseController.text,
                      street: streetController.text,
                      landmark: landmarkController.text,
                      pincode: pincodeController.text,
                      city: cityController.text,
                      state: stateController.text,
                    );

                    Navigator.pop(context, addressmodel);
                    // Handle form submission or navigation
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: const Text(
                    "Save Address",
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
      ),
    );
 }
}