import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/volunteer_form_screen.dart';
import 'screens/home_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/responsive_layout.dart';
import 'screens/volunteer_list_screen.dart';
import 'screens/task_grid_screen.dart';
import 'screens/login_screen.dart';
import 'screens/main_navigation_screen.dart';
import 'transitions/slide_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NGO Grid - Volunteer Coordination Platform',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,

        // 🌿 Global NGO Color Theme
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),

        // 🌿 AppBar Styling
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),

        // 🌿 Global Button Styling
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 15,
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // 🌿 Global Text Styling
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
      ),

      initialRoute: '/',

      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/':
            page = const MainNavigationScreen();
            break;
          case '/home':
            page = const HomeScreen();
            break;
          case '/dashboard':
            page = const DashboardScreen();
            break;
          case '/welcome':
            page = const WelcomeScreen();
            break;
          case '/responsive':
            page = const ResponsiveLayout();
            break;
          case '/volunteers':
            page = const VolunteerListScreen();
            break;
          case '/tasks':
            page = const TaskGridScreen();
            break;
          case '/form':
            page = const VolunteerFormScreen();
            break;
          case '/login':
            page = const LoginScreen();
            break;
          default:
            page = const MainNavigationScreen(); // Fallback route
        }
        return SlideRightRoute(page: page);
      },
    );
  }
}