import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hospital_booking/registration.dart';

class CertificationUploadPage extends StatefulWidget {
  const CertificationUploadPage({super.key});

  @override
  State<CertificationUploadPage> createState() =>
      _CertificationUploadPageState();
}

class _CertificationUploadPageState extends State<CertificationUploadPage> {
  String? qualificationFile;
  String? certificateFile;

  Future<void> pickFile(bool isQualificationFile) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        if (isQualificationFile) {
          qualificationFile = result.files.single.name;
        } else {
          certificateFile = result.files.single.name;
        }
      });
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

            if (qualificationFile != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Uploaded: $qualificationFile",
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

            if (certificateFile != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Uploaded: $certificateFile",
                  style: const TextStyle(fontSize: 14, color: Colors.green),
                ),
              ),

            const SizedBox(height: 40),

            /// Submit Button
            ElevatedButton(
              onPressed: () {
                if (qualificationFile != null && certificateFile != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Files submitted successfully!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Please upload both files before submitting.')),
                  );
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Registration()),
                );
              },
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