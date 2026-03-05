import 'package:flutter/material.dart';
import '../widgets/custom_nav_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

@override
Widget build(BuildContext context) {

  // ignore: unused_local_variable
  final String userRole =
      ModalRoute.of(context)?.settings.arguments as String? ?? "Volunteer";

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

            const SizedBox(height: 20),

            CustomNavButton(
              title: 'Go to Dashboard',
              routeName: '/dashboard',
              icon: Icons.dashboard,
              arguments: 'Volunteer Admin',
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
            ],
          ),
        ),
      ),
    );
  }
}