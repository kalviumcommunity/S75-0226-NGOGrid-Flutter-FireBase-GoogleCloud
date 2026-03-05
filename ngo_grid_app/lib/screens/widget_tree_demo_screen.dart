import 'package:flutter/material.dart';

class WidgetTreeDemoScreen extends StatefulWidget {
  const WidgetTreeDemoScreen({super.key});

  @override
  State<WidgetTreeDemoScreen> createState() => _WidgetTreeDemoScreenState();
}

class _WidgetTreeDemoScreenState extends State<WidgetTreeDemoScreen> {
  int count = 0;
  bool showHelper = true;
  int colorIndex = 0;

  static const List<Color> _colors = <Color>[
    Color(0xFFE8F5E9), // light green
    Color(0xFFFFF3E0), // light orange
    Color(0xFFE3F2FD), // light blue
    Color(0xFFFFEBEE), // light red
  ];

  void _increment() {
    setState(() {
      count++;
    });
  }

  void _toggleHelper(bool value) {
    setState(() {
      showHelper = value;
    });
  }

  void _cycleBackground() {
    setState(() {
      colorIndex = (colorIndex + 1) % _colors.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Tree Demo'), centerTitle: true),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _colors[colorIndex],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Reactive UI • Widget Tree',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                'Count: $count',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: _increment,
                    child: const Text('Increment'),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: _cycleBackground,
                    child: const Text('Change Background'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Show helper'),
                  Switch(value: showHelper, onChanged: _toggleHelper),
                ],
              ),
              if (showHelper) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.info_outline, color: Colors.black54),
                    SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        'Tap Increment to update state.\n'
                        'Toggle switch to hide this helper.\n'
                        'Change background cycles container color.',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
