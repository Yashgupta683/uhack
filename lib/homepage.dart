import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kodikzee2024/chatbot.dart';
import 'package:kodikzee2024/livenavigation.dart';
import 'package:kodikzee2024/login.dart';
import 'package:kodikzee2024/navigation.dart';
import 'package:kodikzee2024/qrscan.dart';
import 'package:kodikzee2024/register.dart';
import 'package:kodikzee2024/ticketdetails.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() {
    return HomepageState();
  }
}

class HomepageState extends State<Homepage> {
  // Selected language
  String selectedLanguage = 'English';

  // Text in different languages
  Map<String, Map<String, String>> languageTexts = {
    'English': {
      'title': 'Notifications',
      'trainInfo': 'Train Information',
      'currentStation': 'Current Station',
      'from': 'From',
      'to': 'To',
      'coachNumber': 'Coach Number',
    },
    'Hindi': {
      'title': 'सूचनाएं',
      'trainInfo': 'ट्रेन जानकारी',
      'currentStation': 'वर्तमान स्टेशन',
      'from': 'से',
      'to': 'तक',
      'coachNumber': 'कोच नंबर',
    },
    'Spanish': {
      'title': 'Notificaciones',
      'trainInfo': 'Información del Tren',
      'currentStation': 'Estación Actual',
      'from': 'De',
      'to': 'A',
      'coachNumber': 'Número de Coche',
    },
    'French': {
      'title': 'Notifications',
      'trainInfo': 'Informations sur le Train',
      'currentStation': 'Station Actuelle',
      'from': 'De',
      'to': 'À',
      'coachNumber': 'Numéro de Voiture',
    },
    'German': {
      'title': 'Benachrichtigungen',
      'trainInfo': 'Zuginformationen',
      'currentStation': 'Aktueller Bahnhof',
      'from': 'Von',
      'to': 'Nach',
      'coachNumber': 'Wagennummer',
    },
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/images/Untitled.png", width: 50),
            const SizedBox(width: 10),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Yatriपथ\n', // First line
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold), // First line text size
                  ),
                  TextSpan(
                    text: 'Your Station Your Way', // Second line
                    style: TextStyle(fontSize: 16), // Second line text size
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.teal,
        actions: [
          PopupMenuButton<String>(
            icon: const FaIcon(FontAwesomeIcons.language), // Globe icon for language
            onSelected: (String result) {
              setState(() {
                selectedLanguage = result; // Update selected language
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'English',
                child: Text('English'),
              ),
              const PopupMenuItem<String>(
                value: 'Hindi',
                child: Text('Hindi'),
              ),
              const PopupMenuItem<String>(
                value: 'Spanish',
                child: Text('Spanish'),
              ),
              const PopupMenuItem<String>(
                value: 'French',
                child: Text('French'),
              ),
              const PopupMenuItem<String>(
                value: 'German',
                child: Text('German'),
              ),
            ],
          ),
          PopupMenuButton<String>(
            onSelected: (String result) {
              if (result == 'Option 1') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to Option1Page
                );
              } else if (result == 'Option 2') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()), // Navigate to Option2Page
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Option 1',
                child: Text('Login'),
              ),
              const PopupMenuItem<String>(
                value: 'Option 2',
                child: Text('Register'),
              ),
               const PopupMenuItem<String>(
                 value: 'Option 3',
                 child: Text('UserID'),)
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body:SingleChildScrollView(
      child:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              languageTexts[selectedLanguage]!['title']!, // Dynamic title
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircularButton(
                  icon: Icons.qr_code_scanner_outlined,
                  label: 'Scan QR',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScanQRPage()), // Navigate to ScanQRPage
                    );
                  },
                ),
                CircularButton(
                  icon: Icons.map_outlined,
                  label: '3D Navigation',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Navigation()), // Navigate to Navigation
                    );
                  },
                ),
                CircularButton(
                  icon: Icons.directions,
                  label: 'Live Navigation',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Livenavigation()), // Navigate to LiveNavigation
                    );
                  },
                ),
                CircularButton(
                  icon: Icons.train,
                  label: 'Ticket Details',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TicketDetails()), // Navigate to TicketDetails
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.teal.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    languageTexts[selectedLanguage]!['trainInfo']!,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(languageTexts[selectedLanguage]!['currentStation']!,
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: languageTexts[selectedLanguage]!['from']!,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.compare_arrows, size: 32),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: languageTexts[selectedLanguage]!['to']!,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      labelText: languageTexts[selectedLanguage]!['coachNumber']!,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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

class CircularButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function onTap;

  const CircularButton({super.key, required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.teal.shade100,
            ),
            child: Icon(icon, size: 40, color: Colors.teal.shade900),
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
