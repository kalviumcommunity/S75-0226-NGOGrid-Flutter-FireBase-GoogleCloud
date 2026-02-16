🌐 NGOGrid – Volunteer Coordination Platform

NGOGrid is a Flutter + Firebase based web and mobile application designed to help NGOs efficiently coordinate volunteers, assign tasks, and track progress during events and relief operations.

📌 Problem Statement

Non-Governmental Organizations (NGOs) often face difficulties while coordinating volunteers for events or relief work. Common challenges include:

Unclear task allocation

Lack of real-time progress tracking

Communication gaps between volunteers and coordinators

Manual coordination leading to delays and inefficiency

These problems become critical during emergency relief operations where time and clarity are essential.

💡 Proposed Solution

NGOGrid introduces a structured workflow-based system that simplifies volunteer coordination by clearly defining tasks, responsibilities, and progress stages.

Each event or campaign is divided into manageable tasks, assigned to volunteers, and tracked in real time—ensuring transparency, accountability, and smooth execution.

🔁 Workflow Model
Event / Relief Campaign
        ↓
    Task Creation
        ↓
    Task Assignment
        ↓
  Task In Progress
        ↓
 Task Completed / Verified

✨ Key Features
👤 Role-Based Access Control

Admin / NGO Manager

Create and manage events

Create, assign, and monitor tasks

Track overall campaign progress

Volunteer

View assigned tasks

Update task status

Communicate within tasks

📊 Event & Campaign Dashboard

Overview of all ongoing and completed events

Task completion progress indicators

Volunteer participation statistics

📝 Task Management System

Create tasks under specific events

Assign tasks to volunteers

Set deadlines and task descriptions

Task status tracking:

Pending

In Progress

Completed

🔄 Real-Time Progress Tracking

Instant updates using Firebase Firestore

Live synchronization across all users

💬 Task-Based Communication

In-task comments and updates

Centralized communication for each activity

🔔 Notifications & Alerts

Task assignment notifications

Deadline reminders

Task completion alerts

📁 Project Structure
The project follows a clean, modular architecture:

```
lib/
├── main.dart          # Entry point of your app
├── screens/           # Individual UI screens
│   └── welcome_screen.dart  # Welcome screen with state management
├── widgets/           # Reusable UI components (future use)
├── models/            # Data structures (future use)
├── services/          # Firebase or API logic (future use)
```

Purpose of each directory:
- `lib/main.dart`: The entry point of the application, containing the main MyApp widget that sets up the MaterialApp with routing.
- `lib/screens/`: Contains individual UI screens representing different views of the application (e.g., welcome screen, login screen, dashboard).
- `lib/widgets/`: Houses reusable UI components that can be shared across multiple screens to maintain consistency and reduce code duplication.
- `lib/models/`: Defines data structures and business objects that represent entities in the application (e.g., User, Task, Event).
- `lib/services/`: Contains logic for external integrations like Firebase, API calls, and other backend communications.

How this structure supports modular app design:
- Separation of concerns: Each directory has a specific responsibility, making the codebase easier to navigate and maintain.
- Scalability: New features can be added without disrupting existing functionality.
- Testability: Components can be tested independently due to their separation.
- Team collaboration: Different team members can work on different parts of the application without conflicts.

Naming conventions:
- Files: Use snake_case (e.g., welcome_screen.dart, user_model.dart)
- Classes: Use PascalCase (e.g., WelcomeScreen, UserModel)
- Variables and methods: Use camelCase (e.g., userName, updateUser())
- Constants: Use snake_case with uppercase (e.g., MAX_TASK_COUNT, APP_THEME_COLOR)

🛠️ Tech Stack
Frontend

Flutter

Responsive UI for mobile & web

Material Design components

Backend & Cloud Services

Firebase Authentication – Secure user login and role management

Cloud Firestore – Real-time database for events, tasks, and users

Firebase Cloud Functions – Backend automation (optional)

Firebase Cloud Messaging (FCM) – Push notifications