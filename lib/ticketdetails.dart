import 'package:flutter/material.dart';
import 'package:kodikzee2024/chatbot.dart';

class TicketDetails extends StatefulWidget{
  const TicketDetails({super.key});

  @override
  State<TicketDetails> createState() {
   return TicketDetailState();
  }

}
class TicketDetailState extends State<TicketDetails>{
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