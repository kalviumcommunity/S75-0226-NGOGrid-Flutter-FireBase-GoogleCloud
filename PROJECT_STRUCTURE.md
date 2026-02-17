# Flutter Project Structure - NGO Grid App

## Introduction

This document outlines the folder structure of the NGO Grid Flutter application. Flutter follows a standardized project structure that organizes code, assets, and platform-specific configurations in a way that promotes maintainability, scalability, and team collaboration.

## Folder Structure Overview

| Folder/File | Purpose |
|-------------|---------|
| `lib/` | Contains all the Dart source code for the application including screens, widgets, models, and services |
| `lib/main.dart` | Entry point of the Flutter application |
| `lib/screens/` | Contains individual UI screen widgets for the application |
| `android/` | Platform-specific configuration and build files for Android |
| `ios/` | Platform-specific configuration and build files for iOS |
| `pubspec.yaml` | Configuration file for dependencies, assets, fonts, and app metadata |
| `assets/` | (Manually created) Storage for images, fonts, JSON files, and other static assets |
| `test/` | Contains unit, widget, and integration tests for the application |
| `build/` | Auto-generated folder containing compiled application builds (not modified manually) |
| `web/` | Platform-specific files for web deployment |
| `windows/`, `linux/`, `macos/` | Platform-specific files for desktop deployments |

## Detailed Folder Descriptions

### `lib/` - Core Application Logic
This is the heart of your Flutter application containing all Dart files:
- **`main.dart`**: The entry point where the application starts execution
- **`screens/`**: Individual UI screens organized by functionality
- **`widgets/`**: Reusable UI components (to be added as needed)
- **`models/`**: Data structure classes (to be added as needed)
- **`services/`**: Business logic and API/Firebase integration code (to be added as needed)

### `android/` - Android Platform Configuration
Contains configuration files and build settings for the Android version of your app:
- Gradle build scripts for Android compilation
- AndroidManifest.xml for permissions and app configuration
- Native Android code if required

### `ios/` - iOS Platform Configuration
Contains configuration and build files for the iOS version of your app:
- Works with Xcode to build and deploy apps on iOS simulators or devices
- Info.plist file defining app metadata for iOS (permissions, icons, etc.)

### `assets/` - Static Resources
This folder needs to be manually created by developers to store:
- Images and graphics
- Custom fonts
- JSON files or other static data
- All assets must be declared in `pubspec.yaml` under the `flutter:` section

### `pubspec.yaml` - Project Configuration
The most important configuration file in a Flutter project:
- Manages dependencies and their versions
- Declares assets, fonts, and environment settings
- Defines app name, version, and other metadata

### `test/` - Automated Tests
Contains automated test files:
- Unit tests for individual functions and classes
- Widget tests for UI components
- Integration tests for feature flows
- Helps ensure code quality and functionality

## Current Project Structure Diagram

```
ngo_grid_app/
├── lib/
│   ├── main.dart                 # App entry point
│   └── screens/                  # UI screens
│       ├── welcome_screen.dart   # Welcome/home screen
│       └── responsive_home.dart  # Responsive home screen
├── android/                      # Android platform files
├── ios/                          # iOS platform files  
├── web/                          # Web platform files
├── windows/                      # Windows platform files
├── macos/                        # macOS platform files
├── linux/                        # Linux platform files
├── assets/                       # (To be created) Static assets
├── test/                         # Test files
├── pubspec.yaml                  # Dependencies & config
├── pubspec.lock                  # Locked dependency versions
└── README.md                     # Project documentation
```

## Scalability and Team Collaboration Benefits

This structure supports:
- **Modularity**: Clear separation of concerns between UI, business logic, and data models
- **Maintainability**: Organized code makes it easier to locate and modify specific functionality
- **Teamwork**: Multiple developers can work on different parts of the application without conflicts
- **Scalability**: Adding new features follows established patterns making growth manageable
- **Platform Independence**: Shared code in `lib/` with platform-specific customizations
- **Testing**: Dedicated test folder enables comprehensive test coverage

## Best Practices for Growth

As the NGO Grid application grows, consider:
- Creating additional folders like `lib/widgets/`, `lib/models/`, and `lib/services/`
- Following consistent naming conventions across the project
- Maintaining clear separation between presentation and business logic
- Regular updates to documentation as features are added