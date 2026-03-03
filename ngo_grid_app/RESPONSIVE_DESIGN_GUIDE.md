# Responsive Design Implementation Guide

## Overview
This guide covers the responsive design implementation in the NGOGrid Flutter application using MediaQuery and LayoutBuilder for adaptive UI across different screen sizes and devices.

---

## Table of Contents
1. [What is Responsive Design](#what-is-responsive-design)
2. [MediaQuery for Adaptive UI](#mediaquery-for-adaptive-ui)
3. [LayoutBuilder for Conditional Layouts](#layoutbuilder-for-conditional-layouts)
4. [Combining MediaQuery and LayoutBuilder](#combining-mediaquery-and-layoutbuilder)
5. [Responsive Utilities](#responsive-utilities)
6. [Implementation Examples](#implementation-examples)
7. [Best Practices](#best-practices)

---

## What is Responsive Design

Responsive design ensures that your app's interface adjusts dynamically to different screen sizes and orientations. Instead of using fixed pixel values, you use relative sizing based on screen dimensions.

### Why it matters:
- ✅ Improves usability on different devices
- ✅ Ensures accessibility and consistent design
- ✅ Helps your app adapt seamlessly to mobile, tablet, and desktop layouts
- ✅ Provides better user experience across all devices

### Device Breakpoints (NGOGrid Standard):
- **Mobile**: Width < 600px
- **Tablet**: Width 600-1024px
- **Desktop**: Width >= 1024px

---

## MediaQuery for Adaptive UI

MediaQuery gives you access to device metrics such as width, height, orientation, and pixel density.

### Getting Device Metrics

```dart
var screenWidth = MediaQuery.of(context).size.width;
var screenHeight = MediaQuery.of(context).size.height;
var orientation = MediaQuery.of(context).orientation;
var pixelDensity = MediaQuery.of(context).devicePixelRatio;
```

### Responsive Container Example

```dart
Container(
  width: screenWidth * 0.8,      // 80% of screen width
  height: screenHeight * 0.1,     // 10% of screen height
  color: Colors.teal,
  child: Center(
    child: Text('Responsive Container')
  ),
);
```

**Result**: The container scales perfectly on all devices, maintaining 80% width and 10% height ratios.

### Responsive Padding Example

```dart
Padding(
  padding: EdgeInsets.all(screenWidth * 0.05), // 5% of screen width
  child: Text('Responsive Padding'),
);
```

---

## LayoutBuilder for Conditional Layouts

LayoutBuilder provides layout constraints and helps you build different widget trees for different screen sizes.

### Basic LayoutBuilder Example

```dart
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth < 600) {
      // Mobile Layout - Vertical
      return Column(
        children: [
          Text('Mobile Layout'),
          Icon(Icons.phone_android, size: 80),
        ],
      );
    } else {
      // Tablet/Desktop Layout - Horizontal
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Tablet Layout'),
          SizedBox(width: 20),
          Icon(Icons.tablet, size: 100),
        ],
      );
    }
  },
);
```

**Key Points**:
- For screens under 600px width: uses vertical (Column) layout
- For larger screens: uses horizontal (Row) layout
- Perfect for tablets or landscape view

---

## Combining MediaQuery and LayoutBuilder

The most powerful approach combines both tools for maximum flexibility.

### Complete Example

```dart
class ResponsiveDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get device metrics with MediaQuery
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text('Responsive Design Demo')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Use LayoutBuilder for constraint-based decisions
          bool isMobile = constraints.maxWidth < 600;
          bool isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
          bool isDesktop = constraints.maxWidth >= 1024;

          return Padding(
            padding: EdgeInsets.all(constraints.maxWidth * 0.05),
            child: isMobile
              ? _buildMobileLayout(screenHeight)
              : isTablet
                ? _buildTabletLayout(screenHeight)
                : _buildDesktopLayout(screenHeight),
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout(double screenHeight) {
    return Column(
      children: [
        Container(
          height: screenHeight * 0.3,
          color: Colors.tealAccent,
          child: Center(child: Text('Mobile View')),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(double screenHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Container(
            height: screenHeight * 0.4,
            color: Colors.orangeAccent,
            child: Center(child: Text('Tablet Left')),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Container(
            height: screenHeight * 0.4,
            color: Colors.tealAccent,
            child: Center(child: Text('Tablet Right')),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(double screenHeight) {
    return Row(
      children: [
        Expanded(child: Container(color: Colors.orange)),
        Expanded(child: Container(color: Colors.purple)),
        Expanded(child: Container(color: Colors.teal)),
      ],
    );
  }
}
```

---

## Responsive Utilities

NGOGrid provides a utility class (`ResponsiveUtils`) to simplify responsive design implementation.

### Usage
```dart
import 'package:ngo_grid_app/utilities/responsive_utils.dart';
```

### Available Methods

#### Device Detection
```dart
ResponsiveUtils.isMobile(context)      // Check if mobile
ResponsiveUtils.isTablet(context)      // Check if tablet
ResponsiveUtils.isDesktop(context)     // Check if desktop
ResponsiveUtils.getDeviceType(context) // Get device type as string
```

#### Screen Metrics
```dart
ResponsiveUtils.screenWidth(context)   // Get screen width
ResponsiveUtils.screenHeight(context)  // Get screen height
ResponsiveUtils.pixelDensity(context)  // Get device pixel ratio
ResponsiveUtils.isLandscape(context)   // Check if landscape
ResponsiveUtils.isPortrait(context)    // Check if portrait
```

#### Responsive Values
```dart
ResponsiveUtils.responsivePadding(context)           // Get responsive padding
ResponsiveUtils.responsiveFontSize(context)          // Get responsive font size
ResponsiveUtils.responsiveHeadingSize(context)       // Get responsive heading size
ResponsiveUtils.getGridColumns(context)              // Get grid columns count
ResponsiveUtils.getContainerWidth(context)           // Get container width
ResponsiveUtils.getResponsiveSpacing(context)        // Get responsive spacing
ResponsiveUtils.getIconSize(context)                 // Get responsive icon size
ResponsiveUtils.getResponsiveBorderRadius(context)   // Get responsive border radius
ResponsiveUtils.getResponsiveElevation(context)      // Get responsive elevation
```

### Extensions
```dart
// Use extensions for cleaner code
context.isMobile           // Check if mobile
context.isTablet           // Check if tablet
context.isDesktop          // Check if desktop
context.screenWidth        // Get screen width
context.screenHeight       // Get screen height
context.deviceType         // Get device type
context.responsivePadding  // Get responsive padding
context.isLandscape        // Check if landscape
context.isPortrait         // Check if portrait
```

---

## Implementation Examples

### Example 1: Responsive Dashboard (responsive_home.dart)

The NGOGrid dashboard uses LayoutBuilder to adapt the grid layout:

*Features*:
- Grid that changes columns based on screen size (1 mobile, 2 tablet, 4 desktop)
- Responsive font sizes for heading
- Dynamic card aspect ratios
- Responsive button sizing

```dart
GridView.count(
  crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 4),
  childAspectRatio: isMobile ? 2 : 1.5,
  children: [/* cards */],
);
```

### Example 2: Responsive Layout (responsive_layout.dart)

Demonstrates different layouts for different device sizes:

*Features*:
- Mobile: Vertical (Column) layout
- Tablet: 2-column (Row) layout
- Desktop: 3-column (Row) layout
- Responsive sizing with percentage-based dimensions

### Example 3: State Management with Responsive UI (state_management_demo.dart)

Integrates responsive design with Flutter state management:

*Features*:
- Responsive counter display
- Adaptive button layouts (vertical on mobile, horizontal on tablet/desktop)
- Dynamic font sizes
- Responsive container sizing

### Example 4: Complete Responsive Demo (responsive_demo_complete.dart)

Comprehensive example showing all best practices:

*Features*:
- Device information display
- MediaQuery metrics showcase
- Responsive container demo
- Font size adaptation
- Grid layout adaptation
- Layout pattern switching based on device

---

## Best Practices

### 1. Use Relative Sizing
```dart
// ✅ Good - Relative sizing
width: screenWidth * 0.8
height: screenHeight * 0.2
padding: EdgeInsets.all(constraints.maxWidth * 0.05)

// ❌ Bad - Fixed sizing
width: 300
height: 200
padding: const EdgeInsets.all(16)
```

### 2. Combine MediaQuery with LayoutBuilder
```dart
// ✅ Best - Use both together
var screenWidth = MediaQuery.of(context).size.width;  // Get metrics
LayoutBuilder(
  builder: (context, constraints) {  // Get constraints
    bool isMobile = constraints.maxWidth < 600;
    // Build UI based on both
  },
);
```

### 3. Define Clear Breakpoints
```dart
static const double mobileBreakpoint = 600;
static const double tabletBreakpoint = 1024;

bool isMobile = screenWidth < mobileBreakpoint;
bool isTablet = screenWidth >= mobileBreakpoint && screenWidth < tabletBreakpoint;
bool isDesktop = screenWidth >= tabletBreakpoint;
```

### 4. Use Responsive Utilities
```dart
// ✅ Good - Clean and reusable
ResponsiveUtils.responsiveFontSize(context, mobileSize: 14, tabletSize: 16, desktopSize: 18)

// Or use extensions
context.responsivePadding
context.isMobile
```

### 5. Test on Different Devices
```dart
// Test on:
// - Small phones (320px - 480px)
// - Tablets (600px - 900px)
// - Large tablets (900px - 1200px)
// - Desktops (1200px+)
// - Both portrait and landscape orientations
```

### 6. Use SingleChildScrollView for Overflow Prevention
```dart
SingleChildScrollView(
  child: Padding(
    padding: EdgeInsets.all(constraints.maxWidth * 0.05),
    child: Column(/* content */),
  ),
);
```

### 7. Handle Orientation Changes
```dart
if (MediaQuery.of(context).orientation == Orientation.portrait) {
  // Portrait layout
} else {
  // Landscape layout
}
```

### 8. Use AspectRatio for Consistent Proportions
```dart
AspectRatio(
  aspectRatio: 16 / 9,
  child: Container(/* content */),
);
```

---

## Responsive Design Checklist

- [ ] All text sizes are responsive
- [ ] All spacing/padding uses relative sizing
- [ ] Container widths adapt to screen size
- [ ] Layouts change based on device type (mobile/tablet/desktop)
- [ ] Images scale responsively
- [ ] Buttons are large enough for touch (min 48x48 dp)
- [ ] No horizontal scrolling on mobile
- [ ] Content fits without overflow
- [ ] Tested on multiple device sizes
- [ ] Tested on both portrait and landscape orientations
- [ ] Used LayoutBuilder for conditional layouts
- [ ] Used MediaQuery for device metrics
- [ ] Followed consistent breakpoints
- [ ] Used ResponsiveUtils for cleaner code

---

## Resources

### Files
- [responsive_home.dart](../screens/responsive_home.dart) - Dashboard with responsive grid
- [responsive_layout.dart](../screens/responsive_layout.dart) - Multi-device layout demo
- [state_management_demo.dart](../screens/state_management_demo.dart) - Responsive state management
- [responsive_demo_complete.dart](../screens/responsive_demo_complete.dart) - Complete reference
- [responsive_utils.dart](../utilities/responsive_utils.dart) - Utility functions

### Flutter Documentation
- [MediaQuery Documentation](https://api.flutter.dev/flutter/material/MediaQuery-class.html)
- [LayoutBuilder Documentation](https://api.flutter.dev/flutter/widgets/LayoutBuilder-class.html)
- [Responsive Design Best Practices](https://flutter.dev/docs/development/ui/layout/responsive)

---

## Contact & Questions

For questions or improvements to the responsive design implementation, please refer to the project documentation or contact the development team.

---

**Last Updated**: March 2026  
**NGOGrid Flutter Firebase GoogleCloud Project**
