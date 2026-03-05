import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Layout'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Define breakpoints for different device sizes
          bool isMobile = constraints.maxWidth < 600;
          bool isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
          // ignore: unused_local_variable
          bool isDesktop = constraints.maxWidth >= 1024;

          return Container(
            padding: EdgeInsets.all(constraints.maxWidth * 0.05),
            child: Column(
              children: [
                // Header Section - Responsive width
                Container(
                  width: isMobile ? double.infinity : constraints.maxWidth * 0.8,
                  height: screenHeight * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Header Section',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                
                // Adaptive Layout based on screen size
                Expanded(
                  child: isMobile
                    ? _buildMobileLayout(screenHeight)
                    : isTablet
                      ? _buildTabletLayout(screenHeight)
                      : _buildDesktopLayout(screenHeight),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Mobile Layout (Column)
  Widget _buildMobileLayout(double screenHeight) {
    return Column(
      children: [
        Container(
          height: screenHeight * 0.25,
          decoration: BoxDecoration(
            color: Colors.amber.shade300,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
              )
            ],
          ),
          child: const Center(
            child: Text(
              'Top Panel (Mobile)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          height: screenHeight * 0.25,
          decoration: BoxDecoration(
            color: Colors.greenAccent.shade100,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
              )
            ],
          ),
          child: const Center(
            child: Text(
              'Bottom Panel (Mobile)',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Tablet Layout (2-column)
  Widget _buildTabletLayout(double screenHeight) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: screenHeight * 0.3,
            decoration: BoxDecoration(
              color: Colors.amber.shade300,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                )
              ],
            ),
            child: const Center(
              child: Text(
                'Left Panel (Tablet)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Container(
            height: screenHeight * 0.3,
            decoration: BoxDecoration(
              color: Colors.greenAccent.shade100,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                )
              ],
            ),
            child: const Center(
              child: Text(
                'Right Panel (Tablet)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Desktop Layout (3-column)
  Widget _buildDesktopLayout(double screenHeight) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: screenHeight * 0.35,
            decoration: BoxDecoration(
              color: Colors.orange.shade300,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                )
              ],
            ),
            child: const Center(
              child: Text(
                'Left Panel (Desktop)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Container(
            height: screenHeight * 0.35,
            decoration: BoxDecoration(
              color: Colors.purple.shade300,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                )
              ],
            ),
            child: const Center(
              child: Text(
                'Center Panel (Desktop)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Container(
            height: screenHeight * 0.35,
            decoration: BoxDecoration(
              color: Colors.teal.shade300,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                )
              ],
            ),
            child: const Center(
              child: Text(
                'Right Panel (Desktop)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}