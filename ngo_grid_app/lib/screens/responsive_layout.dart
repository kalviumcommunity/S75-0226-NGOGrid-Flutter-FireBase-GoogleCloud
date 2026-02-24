import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Layout'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: screenWidth > 600 ? 500 : double.infinity,
              height: 150,
              color: Colors.lightBlueAccent,
              child: const Center(child: Text('Header Section')),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: screenWidth > 600
                ? Row(  // Horizontal layout for tablets/desktops
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.amber,
                          child: const Center(child: Text('Left Panel')),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          color: Colors.greenAccent,
                          child: const Center(child: Text('Right Panel')),
                        ),
                      ),
                    ],
                  )
                : Column(  // Vertical layout for phones
                    children: [
                      Container(
                        height: 150,
                        color: Colors.amber,
                        child: const Center(child: Text('Top Panel')),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 150,
                        color: Colors.greenAccent,
                        child: const Center(child: Text('Bottom Panel')),
                      ),
                    ],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}