import 'package:flutter/material.dart';
import 'package:kodikzee2024/chatbot.dart';
import 'package:kodikzee2024/homepage.dart';
import 'package:kodikzee2024/register.dart';
import 'package:kodikzee2024/voiceas.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  VoiceAssistant _voiceAssistant = VoiceAssistant(isVoiceAssistantEnabled: true, child: Container(),); // Reuse or pass the instance

  @override
  void initState() {
    super.initState();
    _voiceAssistant.initialize();
  }
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.teal,
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Username',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your username',
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
                controller: _passwordController,
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
                    // Add login functionality here
                    final username = _usernameController.text;
                    final password = _passwordController.text;
                    // You can validate and process the login here
                    print('Login with Username: $username and Password: $password');
                    _voiceAssistant.speak('You have successfully login.');
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage()),);
                  },
                  child: const Text('Login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 32),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Navigate to OTP login screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OTPLoginPage()),
                      );
                    },
                    child: const Text('Login with OTP'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Forgot account functionality
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                      );
                    },
                    child: const Text('Forgot Account Details'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      // Navigate to the registration screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: const Text('Register'),
                  ),
                ],
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

class OTPLoginPage extends StatefulWidget {
  OTPLoginPage({super.key});

  @override
  State<OTPLoginPage> createState() => _OTPLoginPageState();
}

class _OTPLoginPageState extends State<OTPLoginPage> {
  VoiceAssistant _voiceAssistant = VoiceAssistant(isVoiceAssistantEnabled: true, child: Container(),);
 // Reuse or pass the instance
  TextEditingController _otpController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _voiceAssistant.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with OTP'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Phone Number',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter your phone number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add OTP login functionality here
                  print('OTP sent');
                },
                child: const Text('Send OTP'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32), // Increased horizontal padding
                ),
              ),
            ),
            const SizedBox(height: 16),

            // OTP
            const Text(
              'Enter OTP',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _otpController,
                    maxLength: 4,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: '****',
                      counterText: "",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add functionality to verify OTP and reset password
                  print('Submit OTP and Reset');
                },
                child: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                ),
              ),
            ),
          ],
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



class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() {
    return _ForgotPasswordPageState();
  }
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  VoiceAssistant _voiceAssistant = VoiceAssistant(isVoiceAssistantEnabled: true, child: Container(),); // Reuse or pass the instance

  TextEditingController _emailPhoneController = TextEditingController();
  TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _voiceAssistant.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // To handle overflow
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Yatriपथ',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),

              // Username/Phone no./Email
              const Text(
                'Username/Phone no/Email',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailPhoneController,
                decoration: const InputDecoration(
                  hintText: 'Enter username, phone no, or email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Informational Text (Placeholder for any additional info)
              const Text(
                'Informational Text',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),

              // OTP
              const Text(
                'Enter OTP',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _otpController,
                      maxLength: 4,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: '****',
                        counterText: "",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Add functionality to verify OTP and reset password
                    print('Submit OTP and Reset');
                  },
                  child: const Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(horizontal:32, vertical: 16),
                  ),
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
        shape: const CircleBorder(),
        child: const Icon(Icons.chat),
      ),
    );
  }
}
