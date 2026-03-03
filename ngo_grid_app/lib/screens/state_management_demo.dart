import 'package:flutter/material.dart';

class StateManagementDemo extends StatefulWidget {
  const StateManagementDemo({super.key});

  @override
  _StateManagementDemoState createState() => _StateManagementDemoState();
}

class _StateManagementDemoState extends State<StateManagementDemo> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('State Management Demo'),
        backgroundColor: Colors.teal.shade600,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          bool isTablet = constraints.maxWidth >= 600;

          return Container(
            color: _counter >= 5 ? Colors.greenAccent.shade100 : Colors.white,
            padding: EdgeInsets.all(constraints.maxWidth * 0.05),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      'Counter State Management',
                      style: TextStyle(
                        fontSize: isMobile ? 24 : 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade700,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),

                    // Counter Display Card
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.08),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.teal.shade300, Colors.teal.shade600],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.shade400,
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Times Pressed',
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            '$_counter',
                            style: TextStyle(
                              fontSize: isMobile ? 60 : 80,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _counter >= 5
                                  ? '✓ Goal Reached!'
                                  : '${5 - _counter} more to goal',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),

                    // Buttons - Responsive Layout
                    isMobile
                        ? Column(
                            children: [
                              _buildActionButton(
                                label: 'Increment',
                                icon: Icons.add,
                                onPressed: _incrementCounter,
                                color: Colors.green,
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              _buildActionButton(
                                label: 'Decrement',
                                icon: Icons.remove,
                                onPressed: _decrementCounter,
                                color: Colors.red,
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              _buildActionButton(
                                label: 'Reset',
                                icon: Icons.refresh,
                                onPressed: _resetCounter,
                                color: Colors.orange,
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildActionButton(
                                label: 'Increment',
                                icon: Icons.add,
                                onPressed: _incrementCounter,
                                color: Colors.green,
                              ),
                              _buildActionButton(
                                label: 'Decrement',
                                icon: Icons.remove,
                                onPressed: _decrementCounter,
                                color: Colors.red,
                              ),
                              _buildActionButton(
                                label: 'Reset',
                                icon: Icons.refresh,
                                onPressed: _resetCounter,
                                color: Colors.orange,
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return SizedBox(
      width: 120,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
