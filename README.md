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