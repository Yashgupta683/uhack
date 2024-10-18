import 'package:flutter/material.dart';
import 'package:kodikzee2024/chatbot.dart';
import 'package:kodikzee2024/voiceas.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

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
  );

  bool flashOn = false; // Toggle for flash
  MobileScannerController cameraController = MobileScannerController(); // Controller for the camera

  @override
  void initState() {
    super.initState();
    _voiceAssistant.initialize();
    _requestCameraPermission(); // Request camera permission on initialization
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;

    if (status.isGranted) {
      // Permission granted, proceed with scanning
    } else if (status.isDenied) {
      // Show a permission popup dialog
      _showPermissionDialog();
    } else if (status.isPermanentlyDenied) {
      // The user has permanently denied access, redirect to settings
      _showSettingsDialog();
    }
  }

  // Show dialog if permission is denied
  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Camera Permission'),
          content: const Text('This app requires camera access to scan QR codes. Please allow camera access.'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                var permission = await Permission.camera.request();
                if (permission.isGranted) {
                  // Proceed with scanning
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Camera permission denied')),
                  );
                }
              },
              child: const Text('Allow'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Deny'),
            ),
          ],
        );
      },
    );
  }

  // Show dialog if permission is permanently denied
  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Camera Permission Denied'),
          content: const Text('You have permanently denied camera access. Please go to settings and allow the permission.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings(); // Redirect user to app settings
              },
              child: const Text('Open Settings'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Toggle flash
  void _toggleFlash() {
    setState(() {
      flashOn = !flashOn;
      flashOn ? cameraController.toggleTorch() : cameraController.toggleTorch();
    });
  }

  // Function to launch URL in the browser
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url); // Convert the string URL to a Uri
    if (await canLaunchUrl(uri)) { // Use canLaunchUrl instead of canLaunch
      await launchUrl(uri); // Use launchUrl instead of launch
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR'),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (BarcodeCapture barcodeCapture) {
              final List<Barcode> barcodes = barcodeCapture.barcodes;
              for (var barcode in barcodes) {
                final String code = barcode.rawValue ?? 'Unknown';
                if (Uri.tryParse(code)?.hasScheme ?? false) {
                  // If the scanned code is a valid URL, launch it
                  _launchURL(code);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Scanned code: $code')),
                  );
                }
                break; // Only process the first detected barcode
              }
            },
          ),
          // Overlay for the scanning effect
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const SizedBox(
                width: 250,
                height: 250,
              ),
            ),
          ),
          // Flash button
          Positioned(
            bottom: 100,
            child: ElevatedButton(
              onPressed: _toggleFlash,
              child: Text(flashOn ? 'Flash Off' : 'Flash On'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            ),
          ),
          // Info text
          Positioned(
            bottom: 50,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.black54,
              child: const Text(
                'Align the QR code within the frame',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Chatbot()),
          );
        },
        shape: CircleBorder(),
        child: const Icon(Icons.chat),
      ),
    );
  }
}
