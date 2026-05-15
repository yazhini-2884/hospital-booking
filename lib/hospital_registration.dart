import 'package:flutter/material.dart';
import 'package:hospital_booking/address_model.dart';
import 'package:hospital_booking/hospital_contactdetails.dart';
import 'package:hospital_booking/hospital_location.dart';
import 'package:hospital_booking/registration.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HospitalRegistration extends StatefulWidget {
  final String hospitalId;

  const HospitalRegistration({super.key, required this.hospitalId});

  @override
  // ignore: library_private_types_in_public_api
  _HospitalRegistrationState createState() => _HospitalRegistrationState();
}

class _HospitalRegistrationState extends State<HospitalRegistration> {
  final hospitalNameController = TextEditingController();
  final registerNumberController = TextEditingController();
  final emailController = TextEditingController();

  Addressmodel? hospitalAddress;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchHospitalData();
  }

  @override
  void dispose() {
    hospitalNameController.dispose();
    registerNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> fetchHospitalData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hospitalId = prefs.getString("hospital_id");

      if (hospitalId == null) {
        setState(() {
          isLoading = false;
          errorMessage = "Hospital ID not found ❌";
        });
        print("Hospital ID not found ❌");
        return;
      }

      print("Fetching hospital data for ID: $hospitalId");

      final response = await http.get(
        Uri.parse(
          "http://192.168.29.236:3000/api/hospital/get?hospital_id=$hospitalId",
        ),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Hospital data received: $data");

        setState(() {
          hospitalNameController.text = data['hospital_name'] ?? '';
          registerNumberController.text = data['register_no'] ?? '';
          emailController.text = data['email'] ?? '';

          // Parse address if it exists
          if (data['address'] != null && data['address'].isNotEmpty) {
            final addressParts = data['address'].split(',');
            if (addressParts.length >= 6) {
              hospitalAddress = Addressmodel(
                houseNumber: addressParts[0].trim(),
                street: addressParts[1].trim(),
                landmark: addressParts[2].trim(),
                pincode: addressParts[3].trim(),
                city: addressParts[4].trim(),
                state: addressParts[5].trim(),
              );
              print("Address parsed successfully: $hospitalAddress");
            }
          }

          isLoading = false;
          errorMessage = null;
        });

        print("Hospital data loaded successfully ✅");
      } else {
        setState(() {
          isLoading = false;
          errorMessage =
              "Failed to load data. Status: ${response.statusCode}";
        });
        print("Error fetching data: ${response.statusCode}");
        print("Response: ${response.body}");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Error: $e";
      });
      print("Exception in fetchHospitalData: $e");
    }
  }

  Future<void> updateHospital() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hospitalId = prefs.getString("hospital_id");

      if (hospitalId == null) {
        print("Hospital ID not found ❌");
        return;
      }

      final response = await http.put(
        Uri.parse("http://192.168.29.236:3000/api/hospital/update"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
            "hospital_id": hospitalId,

          "hospital_name": hospitalNameController.text.isNotEmpty
    ? hospitalNameController.text
    : null,

"register_no": registerNumberController.text.isNotEmpty
    ? registerNumberController.text
    : null,

"email": emailController.text.isNotEmpty
    ? emailController.text
    : null,

"address": hospitalAddress != null
    ? "${hospitalAddress!.houseNumber}, ${hospitalAddress!.street}, ${hospitalAddress!.landmark}, ${hospitalAddress!.pincode}, ${hospitalAddress!.city}, ${hospitalAddress!.state}"
    : null, 
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print("Updated Successfully ✅");

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Hospital details updated ✅")));

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Registration()),
        );
      } else {
        print("Error: ${data}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Hospital Registration",
          style: TextStyle(
            color: Color(
              0xFFFFFFFF,
            ), // Using a white color value (ARGB: 255, 255, 255, 255)
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
              controller: hospitalNameController,
              decoration: InputDecoration(
                labelText: "Hospital Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: registerNumberController,
              decoration: InputDecoration(
                labelText: "Register Number",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
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
                    MaterialPageRoute(
                      builder: (context) => HospitalLocationScreen(),
                    ),
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
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
                                builder: (context) => HospitalLocationScreen(),
                              ),
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
                        onPressed: updateHospital,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
      ),
    );
  }
}
