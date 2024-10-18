import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kodikzee2024/chatbot.dart';
import 'package:kodikzee2024/livenavigation.dart';
import 'package:kodikzee2024/login.dart';
import 'package:kodikzee2024/navigation.dart';
import 'package:kodikzee2024/qrscan.dart';
import 'package:kodikzee2024/register.dart';
import 'package:kodikzee2024/ticketdetails.dart';
import 'package:kodikzee2024/voiceas.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifi_scan/wifi_scan.dart';
import 'package:permission_handler/permission_handler.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() {
    return HomepageState();
  }
}

class HomepageState extends State<Homepage> {
  VoiceAssistant _voiceAssistant = VoiceAssistant(isVoiceAssistantEnabled: true, child:Container(),); // Ensure this class has a default constructor
  bool isVoiceAssistantEnabled = true; // Track if the voice assistant is enabled

  @override
  void initState() {
    super.initState();
    _voiceAssistant.initialize();
    _requestPermissionAndScan();
    if (isVoiceAssistantEnabled) {
      // Start listening for commands once voice assistant is enabled
      _listenForCommands();
    }
  }

  // Function to handle listening for commands
  void _listenForCommands() {
    _voiceAssistant.listen((recognizedWords) {
      print('You said: $recognizedWords');
      _processCommand(recognizedWords); // Process the recognized command
      //_voiceAssistant.speak('$recognizedWords').then((_) {
        // After speaking the recognized words, listen for the next command
        _listenForCommands();
      });
    //});
  }
  // Add this method to handle voice command-based navigation
  void _processCommand(String command) {
    if (command.toLowerCase().contains('qr scanner')) {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>ScanQRPage()));
      _voiceAssistant.speak('Opening QR Scanner');
    } else if (command.toLowerCase().contains('live navigation')) {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>Livenavigation()));
      _voiceAssistant.speak('Opening Live Navigation');
    } else if (command.toLowerCase().contains('ticket details')) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const TicketDetails()));
      _voiceAssistant.speak('Showing Ticket Details');
    }else if (command.toLowerCase().contains('login')) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      _voiceAssistant.speak('Opening login page');
    }
    else if (command.toLowerCase().contains('register')) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RegisterPage()));
      _voiceAssistant.speak('Opening registration page');
    }
    else if (command.toLowerCase().contains('chatbot')) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>Chatbot()));
      _voiceAssistant.speak('Opening chatbot');
    }
    else if (command.toLowerCase().contains('home')) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>Homepage()));
      _voiceAssistant.speak('back to homepage');
    }
    else {
      _voiceAssistant.speak('Sorry, I did not understand the command');
    }
  }

  // Selected language
  String selectedLanguage = 'English';
  List<WiFiAccessPoint> _wifiNetworks = [];


  Future<void> _requestPermissionAndScan() async {
    // Request location permission
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      // Start scanning for Wi-Fi networks
      await WiFiScan.instance.startScan();

      // Listen for scan results
      WiFiScan.instance.onScannedResultsAvailable.listen((List<WiFiAccessPoint> results) {
        setState(() {
          _wifiNetworks = results;
        });
      });
    }
  }



  // UI to display Wi-Fi networks
  Widget wifiNetworkList() {
    return _wifiNetworks.isEmpty
        ? const Center(child: Text('No Wi-Fi networks found'))
        : ListView.builder(
      itemCount: _wifiNetworks.length,
      itemBuilder: (context, index) {
        final network = _wifiNetworks[index];
        return ListTile(
          title: Text(network.ssid),
          subtitle: Text('Signal Strength: ${network.level} dBm'),
          onTap: () {
            // Handle the tap event (connect or show details)
            _connectToWifi(network.ssid);
          },
        );
      },
    );
  }

  // Method to connect to a selected Wi-Fi network
  Future<void> _connectToWifi(String ssid) async {
    bool connected = await WiFiForIoTPlugin.connect(ssid, password: 'your-password', security: NetworkSecurity.WPA);
    if (connected) {
      print('Connected to $ssid');
    } else {
      print('Failed to connect to $ssid');
    }
  }


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

  // Toggle the voice assistant
  void toggleVoiceAssistant(bool isEnabled) {
    setState(() {
      isVoiceAssistantEnabled = isEnabled;
    });

    if (isEnabled) {
      _voiceAssistant.speak('Voice Assistant Enabled').then((_) {
        // Trigger voice assistant to listen for voice commands
        _listenForCommands();
      });
    } else {
      _voiceAssistant.speak('Voice Assistant Disabled');
    }
  }




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
              PopupMenuItem<String>(
                value: 'Option 3',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(isVoiceAssistantEnabled ? 'Voice Assistant On' : 'Voice Assistant Off'),
                    Switch(
                      value: isVoiceAssistantEnabled,
                      onChanged: (bool value) {
                        toggleVoiceAssistant(value); // Toggle voice assistant
                      },
                    ),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Option 4',
                child: Text('UserID'),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
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
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Choose Junction'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: const Text('Howrah Junction'),
                                onTap: () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Navigation(url:'https://app.mappedin.com/map/66eafe82ecc9c8000baa8eb4/directions?floor=m_c9f73d9afc417549&location=s_8fd60a2440cbff54&departure=22.583051374860986%2C88.3427290192081%2Cm_c9f73d9afc417549'),),);
                                  },
                              ),
                              ListTile(
                                title: const Text('Allahabad Junction'),
                                onTap: () {
                                  Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => Navigation(url: 'https://app.mappedin.com/map/671212dde85d7e000b52491b/directions?floor=m_d5bbaad8e0f0a65f&location=s_99d839e6c529c48c&departure=25.46219132495936%2C81.82378617955558%2Cm_d5bbaad8e0f0a65f '), // Update with actual URL
                                    ),
                                  );
                                  },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  CircularButton(
                    icon: Icons.directions,
                    label: 'Live Navigation',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Choose Junction'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: const Text('Howrah Junction'),
                                onTap: () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Livenavigation()),);
                                },
                              ),
                              ListTile(
                                title: const Text('Allahabad Junction'),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Livenavigation()),);
                                },
                              ),
                              ListTile(
                                title: const Text('Bareilly Junction'),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Livenavigation()),);
                                },
                              ),
                              ListTile(
                                title: const Text('Agra Junction'),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Livenavigation()),);
                                },
                              ),
                            ],
                          ),
                        ),
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
        shape: CircleBorder(),
        child:Icon(Icons.chat),

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
