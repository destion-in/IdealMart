import 'dart:async';
import 'package:flutter/material.dart';
import 'package:idealmart/src/ui/pages/intro_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              IntroScreen(), // Replace NextPage with your actual next page
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFF275F61), // Your specified background color
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            'assets/logos/logo.png',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.18,
          ),
          // Your specified image (asset or network
        ),
      ),
    );
  }
}
