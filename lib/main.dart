import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hospital_booking/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp ({super.key});

@override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }

}
class Homepage extends StatelessWidget {
  const Homepage({super.key});
@override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Appointment Booking',
            style: TextStyle(
              color: const Color(0xFFFFFFFF), // Using a white color value (ARGB: 255, 255, 255, 255)
              fontSize: 24,
              fontFamily: 'inter',

              fontWeight: FontWeight.bold,
            
            ),
          ),
        ),
       body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              SizedBox(height: 30),
            Text('Book Your Appointment',
              style: TextStyle(
                color: Colors.black,
                fontSize: 35,   
                fontFamily: 'poppins',
                fontWeight: FontWeight.bold,
                )
            ),
            
             SizedBox(height: 30),
             Center(
              child: Image.asset(
                'assets/appointment.jpg',
                width: 500,
                height: 400,) ,
              ),

          //SizedBox(height:  MediaQuery.of(context).size.height * 0.3), // Add spacing between the title and the button 
          Center(
            child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Signup()),
              );
            },
            style:ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            ),
             child: Text (("Sign Up"), 
               style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'inter',
             )
             )
            ),
          ),
              // Navigate to the signup page},

          SizedBox(height: 15),
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'inter',
                  ),
                  children: [
                    TextSpan(
                      text: "Sign In",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontFamily: 'inter',
                        decoration: TextDecoration.underline, // Add underline to the text
                      ),
                      recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Signup()),
                        );
                      },
                    ),
                  ],
                ),
              ),
          ]  
      ),
        ),
      );
  }
}