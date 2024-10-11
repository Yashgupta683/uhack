import 'package:flutter/material.dart';
import 'package:kodikzee2024/chatbot.dart';

class ScanQRPage extends StatefulWidget {
  const ScanQRPage({super.key});

  @override
  State<StatefulWidget> createState() {
   return ScanQRPageState();
  }
}

class ScanQRPageState extends State<ScanQRPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR'),
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