import 'package:flutter/material.dart';
import 'package:kodikzee2024/chatbot.dart';
import 'package:kodikzee2024/voiceas.dart';

class TicketDetails extends StatefulWidget{
  const TicketDetails({super.key});

  @override
  State<TicketDetails> createState() {
   return TicketDetailState();
  }

}
class TicketDetailState extends State<TicketDetails>{
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
        title: const Text('Ticket Details'),
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