
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:kodikzee2024/const.dart';
import 'package:kodikzee2024/logo.dart'; // Import the logo.dart file

void main(){
  Gemini.init(apiKey: GEMINI_API_KEY);
  runApp(const Yatripath());
}

class Yatripath extends StatelessWidget{
  const Yatripath({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Yatriपथ',
      debugShowCheckedModeBanner: false,
      home: Logopage(title: ''), // Logopage is now in logo.dart
    );
  }
}
