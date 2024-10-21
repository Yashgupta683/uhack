import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceAssistant extends InheritedWidget {
  final FlutterTts _flutterTts = FlutterTts();
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  bool _speechRecognitionAvailable = false;
  bool isVoiceAssistantEnabled;

  VoiceAssistant({
    required this.isVoiceAssistantEnabled,
    required Widget child,
  }) : super(child: child);

  static VoiceAssistant? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VoiceAssistant>();
  }

  // Initializes the TTS engine and Speech-to-Text engine
  Future<void> initialize() async {
    try {
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setPitch(1.0);
      await _flutterTts.setSpeechRate(0.5); // Adjust speech rate if needed

      // Initialize speech-to-text
      _speechRecognitionAvailable = await _speechToText.initialize();
      if (_speechRecognitionAvailable) {
        print('Speech recognition initialized successfully.');
      } else {
        print('Speech recognition not available.');
      }
    } catch (e) {
      print('Error initializing voice assistant: $e');
    }
  }

  // Text-to-Speech functionality
  Future<void> speak(String text) async {
    if (isVoiceAssistantEnabled) {
      try {
        await _flutterTts.speak(text);
        print('Voice Assistant speaking: $text');
      } catch (e) {
        print('Error during speech: $e');
      }
    } else {
      print('Voice Assistant is disabled.');
    }
  }

  // Start listening for speech and pass the result
  Future<void> listen(Function(String) onResult) async {
    if (_speechRecognitionAvailable && !_isListening && isVoiceAssistantEnabled) {
      _isListening = true;

      _speechToText.listen(onResult: (result) {
        if (result.hasConfidenceRating && result.confidence > 0.5) {
          onResult(result.recognizedWords);
        } else {
          print('Low confidence in recognized words.');
        }
      }, onSoundLevelChange: (double level) {
        // Optional: handle sound level changes for feedback
        print('Sound level: $level');
      });

      print('Voice Assistant listening...');
    } else {
      print('Speech recognition not available or already listening.');
    }
  }

  // Stop listening
  Future<void> stopListening() async {
    if (_isListening) {
      await _speechToText.stop();
      _isListening = false;
      print('Voice Assistant stopped listening.');
    }
  }

  // Toggle the state of the voice assistant
  void toggleVoiceAssistant(bool isEnabled) {
    isVoiceAssistantEnabled = isEnabled;
    if (isEnabled) {
      speak('Voice Assistant Enabled');
    } else {
      stopListening();
      speak('Voice Assistant Disabled');
    }
  }

  @override
  bool updateShouldNotify(VoiceAssistant oldWidget) {
    return oldWidget.isVoiceAssistantEnabled != isVoiceAssistantEnabled;
  }

  // Dispose of the resources when no longer needed
  void dispose() {
    stopListening(); // Ensure listening is stopped
    print('Voice Assistant disabled');
  }
}
