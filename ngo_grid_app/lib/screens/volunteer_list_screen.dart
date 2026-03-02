import 'package:flutter/material.dart';

class VolunteerListScreen extends StatelessWidget {
  const VolunteerListScreen({super.key});

  final List<String> volunteers = const [
    "Arun",
    "Priya",
    "kumar",
    "Divya",
    "Karthik",
    "Anitha",
    "Vikram",
    "Meena",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Volunteer List")),
      body: ListView.builder(
        itemCount: volunteers.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(volunteers[index]),
              subtitle: const Text("Active Volunteer"),
            ),
          );
        },
      ),
    );
  }
}