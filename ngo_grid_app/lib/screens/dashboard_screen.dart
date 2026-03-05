import 'package:flutter/material.dart';
import 'widget_tree_demo_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int completedTasks = 0;

  @override
  Widget build(BuildContext context) {

    // 🔹 Receive argument from HomeScreen
    final String userRole =
        ModalRoute.of(context)?.settings.arguments as String? ?? "Volunteer";

    return Scaffold(
      appBar: AppBar(
        title: const Text("NGOGrid Dashboard"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // Header Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [

                  // 🔥 New line added for 3.24
                  Text(
                    "Welcome $userRole",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "Completed Tasks",
                    style: TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "$completedTasks",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Action Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  completedTasks++;
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                "Mark Task as Completed",
                style: TextStyle(fontSize: 16),
              ),
            ),

            const SizedBox(height: 20),

            // Reset Button
            OutlinedButton(
              onPressed: () {
                setState(() {
                  completedTasks = 0;
                });
              },
              child: const Text("Reset Counter"),
            ),

            const SizedBox(height: 30),

            // Navigation Buttons
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 15),

                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/welcome');
                  },
                  child: const Text("Go to Welcome Screen"),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Navigate to Widget Tree Demo
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const WidgetTreeDemoScreen(),
                  ),
                );
              },
              child: const Text("Open Widget Tree Demo"),
            ),
          ],
        ),
      ),
    );
  }
}