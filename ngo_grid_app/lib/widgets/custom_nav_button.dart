import 'package:flutter/material.dart';

class CustomNavButton extends StatelessWidget {
  final String title;
  final String routeName;
  final IconData? icon;
 sprint-2-3.26-firebase-setup
  final Object? arguments; // added

  final Object? arguments;
 main

  const CustomNavButton({
    super.key,
    required this.title,
    required this.routeName,
    this.icon,
    this.arguments,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(
            context,
            routeName,
 sprint-2-3.26-firebase-setup
            arguments: arguments, // pass arguments
          );

          final page = _routeMap[routeName];
          if (page != null) {
            Navigator.push(context, SlideRightRoute(page: page));
          }
    arguments: arguments,
          );
 main
        },
        icon: Icon(icon ?? Icons.arrow_forward),
        label: Text(title),
      ),
    );
  }
}
