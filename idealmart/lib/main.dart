import 'package:flutter/material.dart';
import 'package:idealmart/src/ui/pages/intro_screen.dart';
import 'package:idealmart/src/ui/pages/login_page.dart';
import 'package:idealmart/src/ui/pages/splash_screen.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Set status bar color to transparent
    statusBarIconBrightness:
        Brightness.dark, // Ensures status bar icons are light-colored
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      title: 'Grocery App',

      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      // initialRoute: '/', // Set the initial route
      // routes: {
      //   '/': (context) =>
      //       SplashScreen(), // Home page or initial page of the app
      //   '/login': (context) => LoginPage(), // Login page route
      //   // Define other routes as needed
      // },
      home: SplashScreen(), // Set the SplashScreen as the initial route
      debugShowCheckedModeBanner: false,
    );
  }
}
