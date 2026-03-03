import 'package:flutter/material.dart';

/// Responsive Design Utilities
/// Provides helper functions and constants for managing responsive layouts
class ResponsiveUtils {
  /// Device breakpoints for responsive design
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

  /// Determine if device is mobile (width < 600)
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  /// Determine if device is tablet (600 <= width < 1024)
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= mobileBreakpoint &&
        MediaQuery.of(context).size.width < tabletBreakpoint;
  }

  /// Determine if device is desktop (width >= 1024)
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletBreakpoint;
  }

  /// Get device type as string
  static String getDeviceType(BuildContext context) {
    if (isDesktop(context)) return 'Desktop';
    if (isTablet(context)) return 'Tablet';
    return 'Mobile';
  }

  /// Get screen width
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Get device pixel ratio
  static double pixelDensity(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  /// Check if device is in landscape orientation
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Check if device is in portrait orientation
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// Get responsive padding based on screen size
  static EdgeInsets responsivePadding(BuildContext context) {
    double width = screenWidth(context);
    double padding = width * 0.05;
    return EdgeInsets.all(padding);
  }

  /// Get responsive padding with custom factor
  static EdgeInsets responsivePaddingCustom(
    BuildContext context, {
    double factor = 0.05,
  }) {
    double width = screenWidth(context);
    double padding = width * factor;
    return EdgeInsets.all(padding);
  }

  /// Get responsive font size
  static double responsiveFontSize(
    BuildContext context, {
    double mobileSize = 14,
    double tabletSize = 16,
    double desktopSize = 18,
  }) {
    if (isDesktop(context)) return desktopSize;
    if (isTablet(context)) return tabletSize;
    return mobileSize;
  }

  /// Get responsive heading font size
  static double responsiveHeadingSize(
    BuildContext context, {
    double mobileSize = 24,
    double tabletSize = 28,
    double desktopSize = 32,
  }) {
    if (isDesktop(context)) return desktopSize;
    if (isTablet(context)) return tabletSize;
    return mobileSize;
  }

  /// Get number of grid columns based on screen size
  static int getGridColumns(BuildContext context) {
    if (isDesktop(context)) return 4;
    if (isTablet(context)) return 2;
    return 1;
  }

  /// Get number of grid columns with custom values
  static int getGridColumnsCustom(
    BuildContext context, {
    int mobileColumns = 1,
    int tabletColumns = 2,
    int desktopColumns = 4,
  }) {
    if (isDesktop(context)) return desktopColumns;
    if (isTablet(context)) return tabletColumns;
    return mobileColumns;
  }

  /// Get responsive container width
  static double getContainerWidth(
    BuildContext context, {
    double mobilePercent = 0.9,
    double tabletPercent = 0.8,
    double desktopPercent = 0.6,
  }) {
    double width = screenWidth(context);
    if (isDesktop(context)) return width * desktopPercent;
    if (isTablet(context)) return width * tabletPercent;
    return width * mobilePercent;
  }

  /// Get responsive spacing
  static double getResponsiveSpacing(BuildContext context) {
    if (isDesktop(context)) return 24;
    if (isTablet(context)) return 16;
    return 12;
  }

  /// Get responsive icon size
  static double getIconSize(
    BuildContext context, {
    double mobileSize = 24,
    double tabletSize = 32,
    double desktopSize = 40,
  }) {
    if (isDesktop(context)) return desktopSize;
    if (isTablet(context)) return tabletSize;
    return mobileSize;
  }

  /// Get responsive border radius
  static BorderRadius getResponsiveBorderRadius(BuildContext context) {
    double radius = isDesktop(context) ? 16 : (isTablet(context) ? 12 : 8);
    return BorderRadius.circular(radius);
  }

  /// Get responsive elevation/shadow
  static double getResponsiveElevation(BuildContext context) {
    if (isDesktop(context)) return 8;
    if (isTablet(context)) return 6;
    return 4;
  }
}

/// Responsive Widget Extensions
extension ResponsiveX on BuildContext {
  /// Check if mobile
  bool get isMobile => ResponsiveUtils.isMobile(this);

  /// Check if tablet
  bool get isTablet => ResponsiveUtils.isTablet(this);

  /// Check if desktop
  bool get isDesktop => ResponsiveUtils.isDesktop(this);

  /// Get screen width
  double get screenWidth => ResponsiveUtils.screenWidth(this);

  /// Get screen height
  double get screenHeight => ResponsiveUtils.screenHeight(this);

  /// Get device type
  String get deviceType => ResponsiveUtils.getDeviceType(this);

  /// Get responsive padding
  EdgeInsets get responsivePadding => ResponsiveUtils.responsivePadding(this);

  /// Check if landscape orientation
  bool get isLandscape => ResponsiveUtils.isLandscape(this);

  /// Check if portrait orientation
  bool get isPortrait => ResponsiveUtils.isPortrait(this);
}
