import 'package:flutter/material.dart';
import 'package:kodikzee2024/chatbot.dart';

class Livenavigation extends StatefulWidget{
  const Livenavigation({super.key});

  @override
  State<Livenavigation> createState() {
    return LiveNavigationState();
  }

}
class LiveNavigationState extends State<Livenavigation>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Line Navigation'),
      ),
      body: Container(
        color: Colors.teal
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Chatbot()));
          },
          child: const Icon(Icons.chat),
        ),
    );
  }

}