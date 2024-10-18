import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kodikzee2024/homepage.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:kodikzee2024/const.dart';
void main(){
  Gemini.init( apiKey: GEMINI_API_KEY);
  runApp(const Yatripath());
}

class Yatripath extends StatelessWidget{
  const Yatripath({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Yatriपथ',
      debugShowCheckedModeBanner: false,
      home: Logopage(title: ''),
    );
    }
}

class Logopage extends StatefulWidget{
  const Logopage({super.key,required this.title});
  final String title;

  @override
  State<Logopage> createState()=>LogopageState();
}
class LogopageState extends State<Logopage>{
  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds:4),(){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const Homepage(),
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:SizedBox(width:150,child: Image.asset('assets/images/Untitled.png')) ,
      ),
    );
  }

}
