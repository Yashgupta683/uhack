import 'package:flutter/material.dart';
import 'package:kodikzee2024/chatbot.dart';
import 'package:kodikzee2024/voiceas.dart';

class Livenavigation extends StatefulWidget{
  const Livenavigation({super.key});

  @override
  State<Livenavigation> createState() {
    return LiveNavigationState();
  }

}
class LiveNavigationState extends State<Livenavigation>{
  VoiceAssistant _voiceAssistant = VoiceAssistant(isVoiceAssistantEnabled: true, child:Container(),); // Ensure this class has a default constructor
  bool isVoiceAssistantEnabled = false; // Track if the voice assistant is enabled

  @override
  void initState() {
    super.initState();
    _voiceAssistant.initialize();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Navigation'),
      ),
      body: Container(
        color: Colors.teal
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Chatbot()));
          },
          shape: CircleBorder(),
          child:Icon(Icons.chat),
        ),
    );
  }

}