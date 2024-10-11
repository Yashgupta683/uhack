import 'package:flutter/material.dart';
import 'package:kodikzee2024/chatbot.dart';

class Navigation extends StatefulWidget{
  const Navigation({super.key});

  @override
  State<StatefulWidget> createState() {
    return NavigationState();
  }

}
class NavigationState extends State<Navigation>{
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('3D Navigation'),
    ),
    body: Container(
      color: Colors.teal,
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