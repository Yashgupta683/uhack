import 'package:flutter/material.dart';
import 'package:kodikzee2024/chatbot.dart';
import 'package:kodikzee2024/voiceas.dart';

class TicketDetails extends StatefulWidget {
  const TicketDetails({super.key});

  @override
  State<TicketDetails> createState() {
    return TicketDetailState();
  }
}

class TicketDetailState extends State<TicketDetails> {
  VoiceAssistant _voiceAssistant = VoiceAssistant(isVoiceAssistantEnabled: true, child: Container(),); // Ensure this class has a default constructor
  bool isVoiceAssistantEnabled = false; // Track if the voice assistant is enabled

  // Controllers to hold the text field values
  TextEditingController _pnrController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _statusController = TextEditingController();
  TextEditingController _coachController = TextEditingController();
  TextEditingController _trainNoController = TextEditingController();
  TextEditingController _trainNameController = TextEditingController();

  // Mock data for demonstration
  final Map<String, Map<String, String>> ticketData = {
    "12345": {
      "name": "John Doe",
      "age": "30",
      "gender": "Male",
      "status": "Confirmed",
      "coach": "B2",
      "trainNo": "12034",
      "trainName": "Rajdhani Express"
    },
    "67890": {
      "name": "Jane Smith",
      "age": "28",
      "gender": "Female",
      "status": "Waiting",
      "coach": "C1",
      "trainNo": "22345",
      "trainName": "Shatabdi Express"
    },
  };

  @override
  void initState() {
    super.initState();
    _voiceAssistant.initialize();
  }

  // Method to fetch ticket details based on PNR
  void fetchTicketDetails(String pnr) {
    final details = ticketData[pnr];
    if (details != null) {
      setState(() {
        _nameController.text = details["name"]!;
        _ageController.text = details["age"]!;
        _genderController.text = details["gender"]!;
        _statusController.text = details["status"]!;
        _coachController.text = details["coach"]!;
        _trainNoController.text = details["trainNo"]!;
        _trainNameController.text = details["trainName"]!;
      });
    } else {
      // If PNR not found, clear all fields
      setState(() {
        _nameController.clear();
        _ageController.clear();
        _genderController.clear();
        _statusController.clear();
        _coachController.clear();
        _trainNoController.clear();
        _trainNameController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Details'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // To handle overflow
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PNR Number
              const Text(
                'PNR NO',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _pnrController,
                decoration: const InputDecoration(
                  hintText: 'Enter PNR No.',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  fetchTicketDetails(_pnrController.text);
                },
                child: const Text('Fetch Ticket Details'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
              ),
              const SizedBox(height: 16),

              // Name
              const Text(
                'Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Your Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Age
              const Text(
                'Age',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(
                  hintText: 'Your Age',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Gender
              const Text(
                'Gender',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _genderController,
                decoration: const InputDecoration(
                  hintText: 'Your Gender',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Status
              const Text(
                'Status',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _statusController,
                decoration: const InputDecoration(
                  hintText: 'Ticket Status',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Coach Number
              const Text(
                'Coach NO.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _coachController,
                decoration: const InputDecoration(
                  hintText: 'Your Coach No.',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Train Number
              const Text(
                'Train NO.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _trainNoController,
                decoration: const InputDecoration(
                  hintText: 'Your Train No.',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Train Name
              const Text(
                'Train Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _trainNameController,
                decoration: const InputDecoration(
                  hintText: 'Your Train Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Chatbot()),
          );
        },
        shape: CircleBorder(),
        child: Icon(Icons.chat),
      ),
    );
  }
}
