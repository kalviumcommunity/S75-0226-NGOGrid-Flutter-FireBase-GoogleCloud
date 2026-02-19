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
