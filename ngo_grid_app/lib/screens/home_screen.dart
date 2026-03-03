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

              Text(
                'Welcome to NGO Grid',
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              const SizedBox(height: 10),

              Text(
                'Your Volunteer Coordination Platform',
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 40),

              // 🔹 Dashboard
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
                child: const Text('Go to Dashboard'),
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

              // 🔥 3.18 – ListView
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/volunteers');
                },
                child: const Text('View Volunteers (ListView)'),
              ),

              const SizedBox(height: 20),

              // 🔥 3.18 – GridView
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/tasks');
                },
                child: const Text('View Tasks (GridView)'),
              ),

              const SizedBox(height: 20),

              // 🔥 3.20 – Form
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/form');
                },
                child: const Text('Volunteer Registration Form'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}