import 'package:flutter/material.dart';
import 'package:kodikzee2024/chatbot.dart';
import 'package:kodikzee2024/voiceas.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<StatefulWidget> createState() {
    return NavigationState();
  }
}

class NavigationState extends State<Navigation> {
  MediaQueryData? mediaQuery;
  late WebViewController controller;
  late VoiceAssistant _voiceAssistant;
  bool isVoiceAssistantEnabled = false; // Track if the voice assistant is enabled

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mediaQuery = MediaQuery.of(context); // Store the reference to MediaQuery
  }

  @override
  void initState() {
    super.initState();

    // Initialize WebViewController
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://app.mappedin.com/map/66eafe82ecc9c8000baa8eb4/directions?floor=m_c9f73d9afc417549&location=s_8fd60a2440cbff54&departure=22.583051374860986%2C88.3427290192081%2Cm_c9f73d9afc417549'));

    // Initialize the VoiceAssistant
    _voiceAssistant = VoiceAssistant(
      isVoiceAssistantEnabled: true,
      child: Container(), // Pass a valid child widget
    );
    _voiceAssistant.initialize();
  }

  @override
  void dispose() {
    // Safely use the stored reference to MediaQuery
    print(mediaQuery?.size);

    // Dispose of the VoiceAssistant if necessary
    _voiceAssistant.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('3D Navigation'),
          backgroundColor: Colors.teal,
        ),
        body: WebViewWidget(controller: controller),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Chatbot()));
          },
          child: const Icon(Icons.chat),
        ),
      ),
    );
  }
}
