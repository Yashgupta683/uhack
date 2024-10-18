import 'package:flutter/material.dart';
import 'package:kodikzee2024/chatbot.dart';
import 'package:kodikzee2024/voiceas.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';

class ScanQRPage extends StatefulWidget {
  const ScanQRPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return ScanQRPageState();
  }
}

class ScanQRPageState extends State<ScanQRPage> {
  VoiceAssistant _voiceAssistant = VoiceAssistant(
    isVoiceAssistantEnabled: true,
    child: Container(),
  ); // Ensure this class has a default constructor
  bool isVoiceAssistantEnabled = false; // Track if the voice assistant is enabled
  late CameraController _controller;
  Future<void>? _initializeControllerFuture; // Initialize to nullable

  @override
  void initState() {
    super.initState();
    _voiceAssistant.initialize();
    _requestCameraPermission(); // Request camera permission on initialization
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;

    if (status.isGranted) {
      _initializeCamera(); // Initialize camera if permission is granted
    } else if (status.isDenied) {
      // Request the permission
      if (await Permission.camera.request().isGranted) {
        _initializeCamera(); // Initialize camera after permission is granted
      } else {
        // Handle permission denial (show a message or redirect)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Camera permission denied')),
        );
      }
    } else if (status.isPermanentlyDenied) {
      // The user has permanently denied access, redirect to settings
      openAppSettings();
    }
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;
      _controller = CameraController(firstCamera, ResolutionPreset.high);
      _initializeControllerFuture = _controller.initialize();
      setState(() {}); // Ensure the UI is updated after initialization
    } catch (e) {
      print('Error initializing camera: $e');
      // Show a user-friendly message or fallback UI
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the camera controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR'),
        backgroundColor: Colors.teal,
      ),
      body: _initializeControllerFuture == null
          ? const Center(child: Text('Camera not initialized or permission denied'))
          : FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the camera is initialized, display the preview
            return CameraPreview(_controller);
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Otherwise, display a loading indicator
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Chatbot()),
          );
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}
