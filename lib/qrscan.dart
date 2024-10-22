import 'package:flutter/material.dart';
import 'package:kodikzee2024/chatbot.dart';
import 'package:kodikzee2024/voiceas.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart'; // For haptic feedback

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

  bool flashOn = false;
  MobileScannerController cameraController = MobileScannerController();
  bool isProcessingBarcode = false; // Control to avoid multiple detections
  bool isScanning = true; // Indicates whether scanning is in progress

  @override
  void initState() {
    super.initState();
    _voiceAssistant.initialize();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;

    if (status.isGranted) {
      cameraController.start(); // Start the camera only when permission is granted
    } else if (status.isDenied || status.isRestricted) {
      _showPermissionDialog();
    } else if (status.isPermanentlyDenied) {
      _showSettingsDialog();
    }
  }

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
                  cameraController.start(); // Start camera after permission is granted
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
                Navigator.of(context).pop();
              },
              child: const Text('Deny'),
            ),
          ],
        );
      },
    );
  }

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
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
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
      cameraController.toggleTorch(); // Toggle the torch once
    });
  }

  // Process the QR code and display a dialog with clickable link if it's a valid URL
  void _processBarcode(String code) {
    if (!isProcessingBarcode) {
      isProcessingBarcode = true;
      setState(() {
        isScanning = false; // Stop scanning when QR is detected
      });

      if (Uri.tryParse(code)?.hasScheme ?? false) {
        _showUrlDialog(Uri.parse(code)); // Show URL dialog if valid
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Scanned code: $code')),
        );
      }

      // Haptic feedback on successful QR scan
      HapticFeedback.lightImpact();

      // Voice feedback
      _voiceAssistant.speak("QR code scanned successfully");

      // Delay subsequent barcode processing for a brief period
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isProcessingBarcode = false;
          isScanning = true; // Resume scanning
        });
      });
    }
  }

  // Show a dialog with a clickable link
  void _showUrlDialog(Uri url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Scanned URL'),
          content: GestureDetector(
            onTap: () async {
              if (await canLaunchUrl(url)) {
                final bool launched = await launchUrl(
                  url,
                  mode: LaunchMode.externalApplication, // Explicitly open in external browser
                );
                if (!launched) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to open URL')),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Could not launch URL')),
                );
              }
            },
            child: Text(
              url.toString(),
              style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
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
                _processBarcode(code);
                break;
              }
            },
          ),
          // Animated scanning line inside the scan frame
          Positioned(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const SizedBox(
                    width: 250,
                    height: 250,
                  ),
                ),
                AnimatedOpacity(
                  opacity: isScanning ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    width: 200,
                    height: 5,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
          // Flash button with icon
          Positioned(
            bottom: 100,
            child: IconButton(
              onPressed: _toggleFlash,
              icon: Icon(flashOn ? Icons.flash_on : Icons.flash_off, color: Colors.white),
              iconSize: 50,
              color: Colors.teal,
              tooltip: 'Toggle Flash',
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
          // Scanning status indicator (spinner)
          if (isProcessingBarcode)
            Positioned(
              top: 150,
              child: CircularProgressIndicator(
                color: Colors.teal,
                strokeWidth: 4,
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
