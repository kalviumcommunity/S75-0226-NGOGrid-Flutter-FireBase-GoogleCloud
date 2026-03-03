import 'package:flutter/material.dart';

class CustomNavButton extends StatelessWidget {
  final String title;
  final String routeName;
  final IconData? icon;

  const CustomNavButton({
    super.key,
    required this.title,
    required this.routeName,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, routeName);
        },
        icon: Icon(icon ?? Icons.arrow_forward),
        label: Text(title),
      ),
    );
  }
}