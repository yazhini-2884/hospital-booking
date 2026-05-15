import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hospital_booking/registration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CertificationUploadPage extends StatefulWidget {
  const CertificationUploadPage({super.key});

  @override
  State<CertificationUploadPage> createState() =>
      _CertificationUploadPageState();
}

class _CertificationUploadPageState extends State<CertificationUploadPage> {
  String? qualificationFilePath;
  String? certificateFilePath;

  Future<void> pickFile(bool isQualificationFile) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        if (isQualificationFile) {
          qualificationFilePath = result.files.single.path;
        } else {
          certificateFilePath = result.files.single.path;
        }
      });
    }
  }
   
     // 🔥 UPLOAD API CALL
  Future<void> uploadFiles() async {

    if (qualificationFilePath == null || certificateFilePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Upload both files")),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String? doctorId = prefs.getString("doctor_id");

    if (doctorId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Doctor ID not found")),
      );
      return;
    }

    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("http://192.168.29.236:3000/api/certificate/upload"),
      );

      request.fields["doctor_id"] = doctorId;

      request.files.add(
        await http.MultipartFile.fromPath(
          "qualification",
          qualificationFilePath!,
        ),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          "certificate",
          certificateFilePath!,
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Upload Success ✅")),
        );

        // ✅ Navigate only after success
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Registration()),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Upload Failed ❌")),
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
          'Certification Upload',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Qualification Upload
            /// Qualification File Upload
             Text(
                "Please upload your qualification certificate .",
                style: TextStyle(fontSize: 16, 
                color: Colors.black54),
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
              ),
              
            const SizedBox(height: 25),
            ElevatedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload File'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                pickFile(true);
              },
            ),

            if (qualificationFilePath != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Uploaded: $qualificationFilePath",
                  style: const TextStyle(fontSize: 14, color: Colors.green),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Please upload your registration certificate .",
                style: TextStyle(fontSize: 16, 
                color: Colors.black54),
                textAlign: TextAlign.center,
                textDirection: TextDirection.ltr,
              ),

            const SizedBox(height: 25),

            /// Registration Upload
            ElevatedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload file'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                pickFile(false);
              },
            ),

            if (certificateFilePath != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Uploaded: $certificateFilePath",
                  style: const TextStyle(fontSize: 14, color: Colors.green),
                ),
              ),

            const SizedBox(height: 40),

            /// Submit Button
            ElevatedButton(
              onPressed: uploadFiles,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}