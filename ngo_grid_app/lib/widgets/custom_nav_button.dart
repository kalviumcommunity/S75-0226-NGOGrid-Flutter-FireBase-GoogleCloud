import 'package:flutter/material.dart';
import '../transitions/slide_transition.dart';
import '../screens/dashboard_screen.dart';
import '../screens/welcome_screen.dart';
import '../screens/responsive_layout.dart';
import '../screens/volunteer_list_screen.dart';
import '../screens/task_grid_screen.dart';
import '../screens/volunteer_form_screen.dart';

class CustomNavButton extends StatelessWidget {
  final String title;
  final String routeName;
  final IconData? icon;
  final Object? arguments;   // added

  const CustomNavButton({
    super.key,
    required this.title,
    required this.routeName,
    this.icon,
    this.arguments,
  });

  // A map to get the widget from the route name
  static final Map<String, Widget> _routeMap = {
    '/dashboard': const DashboardScreen(),
    '/welcome': const WelcomeScreen(),
    '/responsive': const ResponsiveLayout(),
    '/volunteers': const VolunteerListScreen(),
    '/tasks': const TaskGridScreen(),
    '/form': const VolunteerFormScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
sprint-2-3.24-navigation-arguments
          Navigator.pushNamed(
            context,
            routeName,
            arguments: arguments,   // pass arguments
          );

          final page = _routeMap[routeName];
          if (page != null) {
            Navigator.push(context, SlideRightRoute(page: page));
          }
 main
        },
        icon: Icon(icon ?? Icons.arrow_forward),
        label: Text(title),
      ),
    );
  }
}