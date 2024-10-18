import 'package:flutter/material.dart';

class Chatbot extends StatefulWidget{
  const Chatbot({super.key});

  @override
  State<Chatbot> createState() {
    return ChatbotState();
  }

}
class ChatbotState extends State<Chatbot>{
  final TextEditingController _controller = TextEditingController();
  List<String> _messages = [];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(_controller.text); // Add user message to the list
        _messages.add("Bot: This is a simulated response."); // Simulated bot response
        _controller.clear(); // Clear the input field after sending
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Enter a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage, // Call the send message function
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}