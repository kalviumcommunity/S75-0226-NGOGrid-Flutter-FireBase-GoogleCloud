import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isButtonPressed = false;

  void _toggleButtonState() {
    setState(() {
      _isButtonPressed = !_isButtonPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NGO Grid - Welcome'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to NGO Grid',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Icon(
              Icons.volunteer_activism,
              size: 100,
              color: _isButtonPressed 
                ? Colors.green 
                : Colors.blue,
            ),
            const SizedBox(height: 20),
            Text(
              _isButtonPressed 
                ? 'Thank you for volunteering!' 
                : 'Join us in making a difference',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _toggleButtonState,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isButtonPressed 
                  ? Colors.green 
                  : Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                _isButtonPressed ? 'Volunteering!' : 'Get Started',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}