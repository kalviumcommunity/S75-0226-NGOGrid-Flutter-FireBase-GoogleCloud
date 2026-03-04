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

## State Management Demo

### Project Overview
A Flutter demonstration of **Stateful Widgets** and **setState()** for managing local state. This counter application showcases how Flutter's reactive model works through dynamic UI updates based on user interactions.

### Code Implementation

**StateManagementDemo - StatefulWidget Structure**
```dart
class StateManagementDemo extends StatefulWidget {
  const StateManagementDemo({super.key});

  @override
  _StateManagementDemoState createState() => _StateManagementDemoState();
}
```

**State Management with setState()**
```dart
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
}
```

**Conditional State Update**
```dart
Container(
  color: _counter >= 5 ? Colors.greenAccent : Colors.white,
  child: Center(
    child: Text('Count: $_counter'),
  ),
)
```

### Screenshots
*Before State Change*: Counter at 0, white background
*After State Change*: Counter at 5+, green background indicating threshold reached
*Button Interaction*: Increment/Decrement buttons update counter dynamically

### Reflection

**What's the difference between Stateless and Stateful widgets?**
StatelessWidget is immutable with no internal state—its properties never change once built. StatefulWidget can change dynamically based on user interactions or data updates. Use StatelessWidget for static UI elements (text, logos) and StatefulWidget for interactive elements (counters, forms, toggles).

**Why is setState() important for Flutter's reactive model?**
setState() notifies Flutter's rendering engine that the widget's data has changed, triggering a rebuild of the affected UI. Without it, variable changes won't reflect in the UI. It enables Flutter's reactive programming model where the UI automatically responds to state changes, maintaining consistency between data and visual representation.

**How can improper use of setState() affect performance?**
Calling setState() too frequently causes unnecessary rebuilds, consuming CPU and battery resources. Placing setState() inside build() creates infinite rebuild loops. Wrapping unrelated widgets in setState() rebuilds more UI than needed. Best practice: Update only the minimal state necessary and use smaller widgets to limit rebuild scope.

## Responsive Design Implementation

### Overview
Implements responsive design using **MediaQuery** and **LayoutBuilder** for mobile (< 600px), tablet (600-1024px), and desktop (≥ 1024px) devices.

### Code Snippets

**MediaQuery Example**
```dart
Container(
  width: screenWidth * 0.8,
  height: screenHeight * 0.1,
  padding: EdgeInsets.all(screenWidth * 0.05),
)
```

**LayoutBuilder Example**
```dart
LayoutBuilder(
  builder: (context, constraints) {
    bool isMobile = constraints.maxWidth < 600;
    return isMobile ? Column(...) : Row(...);
  },
)
```

### Responsive Files
- [responsive_layout.dart](lib/screens/responsive_layout.dart)
- [responsive_home.dart](lib/screens/responsive_home.dart)
- [state_management_demo.dart](lib/screens/state_management_demo.dart)
- [responsive_utils.dart](lib/utilities/responsive_utils.dart)

### Screenshots
- **Mobile**: Single-column layout, vertical buttons, responsive padding
- **Tablet**: 2-column grid, horizontal panels, medium spacing
- **Desktop**: 4-column grid, 3-panel layout, generous spacing

### Reflection

**Why is responsiveness important in mobile development?**
Ensures optimal UX across devices. Single codebase vs multiple apps. Improves accessibility and reduces poor app ratings.

**How does LayoutBuilder differ from MediaQuery?**
MediaQuery retrieves static device metrics. LayoutBuilder provides dynamic constraints and rebuilds on changes. Best practice: use both together.

**How could your team scale the app design efficiently?**
Create centralized ResponsiveUtils class with reusable methods. Define consistent breakpoints across screens. Extract responsive patterns into custom widgets.

## Animations

### Project Title
**NGO Grid - Animations**

### Description
Implemented various animations to enhance the user experience, including:
- **Implicit Animations:** `AnimatedContainer` for color changes and `AnimatedOpacity` for fade effects.
- **Explicit Animations:** `AnimationController` for more complex animations like list and grid item animations.
- **Page Transitions:** A custom `PageRouteBuilder` for smooth slide transitions between screens.

### Code Snippets

**AnimatedContainer**
```dart
AnimatedContainer(
  duration: const Duration(seconds: 1),
  color: _toggled ? Colors.teal : Colors.green,
  // ...
)
```

**Fade and Slide Animation**
```dart
FadeTransition(
  opacity: _animation,
  child: SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(_animation),
    child: // ...
  ),
)
```

### Reflection

**Why are animations important for UX?**
Animations guide user attention, provide visual feedback, and make the app feel more responsive and intuitive.

**What are the differences between implicit and explicit animations?**
- **Implicit animations** are simpler and automatically handle the animation when a property changes.
- **Explicit animations** provide more control and are better for complex or custom effects, using an `AnimationController`.

**How can you apply animations effectively in your team’s main app project?**
Start with subtle animations for common interactions like button presses and screen transitions. Use animations to draw attention to important information or changes in state. Ensure animations are quick and don't distract from the user's task.
