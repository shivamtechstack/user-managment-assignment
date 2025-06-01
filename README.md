# Flutter User Management App

A user management system built with Flutter using **BLoC pattern**, **clean architecture**, **API integration** (DummyJSON), and advanced UI features like **theme toggling**, **pagination**, **pull-to-refresh**, and **search**.

---

## 🚀 Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/flutter-user-management.git
   cd flutter-user-management
Install dependencies:

flutter pub get
Run the app:

flutter run
To run on a specific device:

flutter devices
flutter run -d <device_id>
📱 Project Overview
This app displays a list of users fetched from DummyJSON API, along with their associated posts and todos. It supports:

Viewing user details with nested posts and todos

Pull-to-refresh

Pagination and lazy loading

Dark/light theme toggle

Clean and maintainable code structure using the BLoC pattern

🧠 Architecture
The app follows the Clean Architecture principles:

🧱 Layers
Presentation Layer (UI + BLoC):

Contains screens and widgets

BLoC manages state and events

Domain Layer (Repositories):

Interfaces for fetching data from providers

Data Layer (Providers):

Actual implementation of APIs using HTTP calls

🧩 Design Patterns
BLoC (for state management)

Repository pattern (to abstract data sources)

Dependency Injection using MultiRepositoryProvider

📁 Folder Structure
lib/
│
├── blocs/
│   ├── user_bloc.dart
│   ├── user_event.dart
│   └── user_state.dart
│
├── models/
│   ├── user.dart
│   ├── post.dart
│   └── todo.dart
│
├── providers/
│   └── user_api_provider.dart
│
├── repositories/
│   ├── user_repository.dart
│   ├── post_repository.dart
│   └── todo_repository.dart
│
├── screens/
│   └── user_list_screen.dart
│
└── main.dart

🌗 Light/Dark Theme Toggle
Easily switch between light and dark modes from the AppBar. The theme state is maintained using a ValueNotifier and can be extended to persist across sessions.

📸 Screenshots
<p align="center"> <img src="assets/screenshots/home_light.png" width="300"/>
<img src="assets/screenshots/home_dark.png" width="300"/>
<img src="assets/screenshots/user_details.png" width="300"/> 
<img src="assets/screenshots/pull_to_refresh.png" width="300"/> 
<img src="assets/screenshots/theme_toggle.png" width="300"/> </p>

🎥 Video Preview
https://user-images.githubusercontent.com/your-video-id/demo-preview.mp4

(Replace with actual video URL or GitHub-uploaded asset)

👤 By : 
Shivam Yadav
📧 shivam16yadav16@gmail.com

