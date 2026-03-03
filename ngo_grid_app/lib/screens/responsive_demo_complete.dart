import 'package:flutter/material.dart';

/// Complete Responsive Design Demo
/// This screen demonstrates best practices using MediaQuery + LayoutBuilder together
class ResponsiveDemoComplete extends StatelessWidget {
  const ResponsiveDemoComplete({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery for getting device metrics
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Design Complete Demo'),
        backgroundColor: Colors.deepPurple.shade600,
        elevation: 8,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // LayoutBuilder for constraint-based layout decisions
          bool isMobile = constraints.maxWidth < 600;
          bool isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
          bool isDesktop = constraints.maxWidth >= 1024;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(constraints.maxWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Device Info Display
                  _buildInfoCard(
                    title: 'Device Information',
                    info: [
                      'Screen Width: ${screenWidth.toStringAsFixed(0)}px',
                      'Screen Height: ${screenHeight.toStringAsFixed(0)}px',
                      'Orientation: ${orientation == Orientation.portrait ? "Portrait" : "Landscape"}',
                      'Device Type: ${_getDeviceType(isMobile, isTablet, isDesktop)}',
                      'Pixel Density: ${MediaQuery.of(context).devicePixelRatio.toStringAsFixed(2)}',
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Responsive Container Demo
                  _buildResponsiveContainerDemo(screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.03),

                  // Font Size Adaptation Demo
                  _buildFontAdaptationDemo(isMobile, isTablet),
                  SizedBox(height: screenHeight * 0.03),

                  // Responsive Grid Demo
                  _buildResponsiveGridDemo(isMobile, isTablet, isDesktop),
                  SizedBox(height: screenHeight * 0.03),

                  // Layout Pattern Demo
                  _buildLayoutPatternDemo(isMobile, constraints.maxWidth),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Display device information
  Widget _buildInfoCard({
    required String title,
    required List<String> info,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        border: Border.all(color: Colors.deepPurple.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade700,
            ),
          ),
          const SizedBox(height: 12),
          ...info
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  /// Demo: Container with responsive sizing
  Widget _buildResponsiveContainerDemo(double screenWidth, double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Responsive Container (80% width, 20% height)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade700,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: screenWidth * 0.8,
          height: screenHeight * 0.2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade300, Colors.blue.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade300,
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Center(
            child: Text(
              'Scales with Screen Size',
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Demo: Font size adaptation
  Widget _buildFontAdaptationDemo(bool isMobile, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Font Size Adaptation',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade700,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Column(
            children: [
              Text(
                'Heading Size',
                style: TextStyle(
                  fontSize: isMobile ? 24 : (isTablet ? 28 : 32),
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Body Text Size',
                style: TextStyle(
                  fontSize: isMobile ? 14 : (isTablet ? 16 : 18),
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Demo: Responsive grid layout
  Widget _buildResponsiveGridDemo(
      bool isMobile, bool isTablet, bool isDesktop) {
    int crossAxisCount = isMobile ? 2 : (isTablet ? 3 : 4);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Responsive Grid (${crossAxisCount} columns)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade700,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.0,
          children: List.generate(
            6,
            (index) => Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.shade300,
                    Colors.orange.shade600,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.shade300,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Center(
                child: Text(
                  'Item ${index + 1}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Demo: Different layout patterns based on screen size
  Widget _buildLayoutPatternDemo(bool isMobile, double maxWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Layout Pattern Demo',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.purple.shade700,
          ),
        ),
        const SizedBox(height: 12),
        isMobile
            ? Column(
                children: [
                  _buildPatternBox('Box 1', Colors.red),
                  const SizedBox(height: 12),
                  _buildPatternBox('Box 2', Colors.blue),
                  const SizedBox(height: 12),
                  _buildPatternBox('Box 3', Colors.green),
                ],
              )
            : Row(
                children: [
                  Expanded(child: _buildPatternBox('Box 1', Colors.red)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildPatternBox('Box 2', Colors.blue)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildPatternBox('Box 3', Colors.green)),
                ],
              ),
      ],
    );
  }

  /// Helper widget for pattern demo
  Widget _buildPatternBox(String title, Color color) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }

  /// Helper method to determine device type
  String _getDeviceType(bool isMobile, bool isTablet, bool isDesktop) {
    if (isDesktop) return 'Desktop';
    if (isTablet) return 'Tablet';
    return 'Mobile';
  }
}
