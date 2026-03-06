import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _toggled = false;

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
              GestureDetector(
                onTap: () {
                  setState(() {
                    _toggled = !_toggled;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: _toggled ? Colors.teal : Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.volunteer_activism,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
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
 sprint-2-3.26-firebase-setup

              const SizedBox(height: 40),

              const SizedBox(height: 20),

              CustomNavButton(
                title: 'Login',
                routeName: '/login',
                icon: Icons.login,
              ),

              const SizedBox(height: 15),

              CustomNavButton(
                title: 'Go to Dashboard',
                routeName: '/dashboard',
                icon: Icons.dashboard,
              ),

              const SizedBox(height: 15),

              CustomNavButton(
                title: 'View Welcome Screen',
                routeName: '/welcome',
                icon: Icons.waving_hand,
              ),

              const SizedBox(height: 15),

              CustomNavButton(
                title: 'View Responsive Layout',
                routeName: '/responsive',
                icon: Icons.phone_android,
              ),

              const SizedBox(height: 15),

              CustomNavButton(
                title: 'View Volunteers (ListView)',
                routeName: '/volunteers',
                icon: Icons.people,
              ),

              const SizedBox(height: 15),

              CustomNavButton(
                title: 'View Tasks (GridView)',
                routeName: '/tasks',
                icon: Icons.grid_view,
              ),

              const SizedBox(height: 15),

              CustomNavButton(
                title: 'Volunteer Registration Form',
                routeName: '/form',
                icon: Icons.app_registration,
              ),
 main
            ],
          ),
        ),
      ),
    );
  }
}
