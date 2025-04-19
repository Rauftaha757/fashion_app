import 'dart:async';
import 'package:exp/app_screens/login%20and%20signup%20page.dart';
import 'package:flutter/material.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreen();
}

class _splashscreen extends State<splashscreen> {
  @override
  void initState() {
    super.initState();


    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: Center(
        child: Image.asset(
          'assets/images/logo_suit.gif',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
