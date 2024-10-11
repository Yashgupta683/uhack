import 'package:flutter/material.dart';

class Chatbot extends StatefulWidget{
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() {
    return ChatbotState();
  }

}
class ChatbotState extends State<Chatbot>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
      ),
      body: Container(
        color: Colors.teal,
      ),
    );
  }

}