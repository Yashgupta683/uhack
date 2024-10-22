import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kodikzee2024/homepage.dart';

class Logopage extends StatefulWidget {
  const Logopage({super.key, required this.title});
  final String title;

  @override
  State<Logopage> createState() => LogopageState();
}

class LogopageState extends State<Logopage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 150,
          child: Image.asset('assets/images/Untitled.png'),
        ),
      ),
    );
  }
}
