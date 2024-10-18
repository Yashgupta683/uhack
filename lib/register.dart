import 'package:flutter/material.dart';
import 'package:kodikzee2024/chatbot.dart';
import 'package:kodikzee2024/homepage.dart';
import 'package:kodikzee2024/voiceas.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() {
    return RegisterPageState();
  }
}
class RegisterPageState extends State<RegisterPage> {
  VoiceAssistant _voiceAssistant = VoiceAssistant(isVoiceAssistantEnabled: true, child: Container(),); // Reuse or pass the instance

  @override
  void initState() {
    super.initState();
    _voiceAssistant.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Page"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Username',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Email',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Password',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle registration logic here
                  print('Registering user');
                  // Speak confirmation after registration (Point 6)
                  _voiceAssistant.speak('You have successfully registered.');

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Homepage()),
                  );
                },
                child: const Text('Register'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show options for voice assistant or chatbot
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Choose Action'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.mic),
                    title: const Text('Use Voice Assistant'),
                    onTap: () {
                      Navigator.of(context).pop();
                      // Trigger voice assistant to listen for voice commands
                      _voiceAssistant.listen((recognizedWords) {
                        print('You said: $recognizedWords');
                        _voiceAssistant.speak(' $recognizedWords');
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.chat),
                    title: const Text('Open Chatbot'),
                    onTap: () {
                      Navigator.of(context).pop();
                      // Navigate to the chatbot screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Chatbot()),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}
