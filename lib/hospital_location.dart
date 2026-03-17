

import 'package:flutter/material.dart';
import 'package:hospital_booking/address_model.dart';

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
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Hospital Name',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              /// House Number
              TextField(
                controller: houseController,
                decoration: const InputDecoration(
                  labelText: 'House Number',
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