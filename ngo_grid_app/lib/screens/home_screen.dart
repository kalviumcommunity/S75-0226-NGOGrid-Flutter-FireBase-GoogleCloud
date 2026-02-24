import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NGO Grid - Home'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.volunteer_activism,
                size: 100,
                color: Colors.green,
              ),
              const SizedBox(height: 20),

              const Text(
                'Welcome to NGO Grid',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Volunteer Coordination Platform',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 40),

              // 🔹 Dashboard
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  'Go to Dashboard',
                  style: TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Welcome
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/welcome');
                },
                child: const Text('View Welcome Screen'),
              ),

              const SizedBox(height: 20),

              // 🔹 Responsive Layout
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/responsive');
                },
                child: const Text('View Responsive Layout'),
              ),

              const SizedBox(height: 20),


              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/volunteers');
                },
                child: const Text('View Volunteers (ListView)'),
              ),

              const SizedBox(height: 20),


              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/tasks');
                },
                child: const Text('View Tasks (GridView)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}