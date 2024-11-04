import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quiz_app/controller/auth_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
    void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => AuthPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width:  MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/splash_back.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(child: Image.asset("assets/splash_front.png"))
        ],
      ),
    );
  }
}



