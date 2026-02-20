# NGO Grid - Volunteer Coordination Platform

A Flutter application designed to connect NGOs, volunteers, and communities for effective disaster relief and social impact coordination.

## Summary

This project follows Flutter's standard project structure with modular organization. For a detailed breakdown of each folder and file purpose, see our [PROJECT_STRUCTURE.md](../PROJECT_STRUCTURE.md) documentation.


## Reflection

### Why is it important to understand each folder's purpose?

Understanding each folder's purpose is crucial because:
- It ensures code is placed in the correct location, maintaining organization
- It makes it easier for developers to locate specific functionality
- It helps maintain consistency across the codebase
- It reduces the learning curve for new team members
- It facilitates proper separation of concerns between UI, business logic, and data layers

### How does a well-organized structure improve teamwork and development speed?

A well-organized structure enhances teamwork and development speed by:
- Allowing multiple developers to work on different modules without conflicts
- Making code reviews more efficient since reviewers know where to expect certain functionality
- Reducing time spent searching for specific code components
- Enabling parallel development on different features
- Facilitating onboarding of new team members
- Improving maintainability and reducing bugs due to clear separation of responsibilities

## Widget Tree Demo

This app includes a screen to illustrate Flutter's widget tree and reactive UI model. Access it from the Dashboard via “Open Widget Tree Demo”.

### Widget Hierarchy (indent-based)

Scaffold  
┣ AppBar  
┗ Body  
 ┗ Center  
  ┗ Container  
   ┗ Column  
    ┣ Text (title)  
    ┣ Text (count)  
    ┣ Row  
    ┃ ┣ ElevatedButton (Increment)  
    ┃ ┗ OutlinedButton (Change Background)  
    ┣ Row  
    ┃ ┣ Text ('Show helper')  
    ┃ ┗ Switch (toggle visibility)  
    ┗ if (showHelper) Row [Icon, Text]

### Reactive Updates

- Increment button updates `count` via `setState`, rebuilding the count Text.
- Change Background cycles a predefined color list for the Container.
- Switch toggles the visibility of the helper Row.

## Multi-Screen Navigation

### Project Title
**NGO Grid - Volunteer Coordination Platform**

### Navigation Setup Summary
Flutter app with 3-screen navigation using MaterialApp named routes for NGO volunteer management.

### Code Implementation

**main.dart - Route Configuration**
```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => const HomeScreen(),
    '/dashboard': (context) => const DashboardScreen(),
    '/welcome': (context) => const WelcomeScreen(),
  },
)
```

**Home Screen Navigation**
```dart
ElevatedButton(
  onPressed: () {
    Navigator.pushNamed(context, '/dashboard');
  },
  child: const Text('Go to Dashboard'),
)
```

**Dashboard Screen Navigation**
```dart
ElevatedButton(
  onPressed: () {
    Navigator.pop(context);
  },
  child: const Text('Back to Home'),
)
```

**Welcome Screen Navigation**
```dart
ElevatedButton(
  onPressed: () {
    Navigator.pop(context);
  },
  child: const Text('Back to Home'),
)
```

### Screenshots
*Home Screen*: NGO Grid welcome interface with navigation buttons
*Dashboard Screen*: Task management with back navigation
*Navigation Flow*: Smooth transitions between screens

### Reflection

**How Navigator manages app stack:**
Uses stack-based system - screens pushed on top, popped off. Maintains navigation history for back functionality.

**Benefits of named routes:**
1. Centralized route management in one location
2. Type safety with compile-time route validation
3. Better organization and maintainability
4. Deep linking support for direct screen access
5. Scalable architecture for large applications
