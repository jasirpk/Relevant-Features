import 'package:flutter/material.dart';
import 'package:flutter_demo/controller/facebook.dart';
import 'package:flutter_demo/controller/google_auth.dart';
import 'package:flutter_demo/view/pages/home.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/flight.jpg',
                ),
                fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Card(
                elevation: 10,
                child: Container(
                  height: screenHeight * 0.3,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 127, 169, 241),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final userCredential =
                              await GoogleSignInC.signWithGoogle();

                          if (userCredential != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: Colors.blue,
                                  content: Text('Sign in added successfully!')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('Sign in failed or canceled')),
                            );
                          }
                        },
                        child: Image.asset(
                          'assets/images/google.png',
                          height: 80,
                        ),
                      ),
                      Text(
                        'or',
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final userCredential =
                              await FacebookSignInC.signWithFacebook();
                          if (userCredential != null) {
                            // Sign in was successful
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.blue,
                                content: Text(
                                    'Facebook Sign in added successfully!'),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                          } else {
                            // Sign in failed or canceled
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                    'Facebook Sign in authentication failed!'),
                              ),
                            );
                          }
                        },
                        child: Image.asset(
                          'assets/images/facebook.png',
                          height: 80,
                        ),
                      )
                    ],
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
