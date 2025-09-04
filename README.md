📱 e-PMIS RRPM Mobile Application (Flutter)
🌐 Overview
The RRPM mobile application is part of the National electronic-Project Management Information System (e-PMIS) of Bangladesh, a centralized digital platform for project management and monitoring.
This mobile app enables users (on both Android and iOS) to easily access project-related data and perform approvals directly from their devices. It brings transparency, accessibility, and efficiency to project tracking, budget monitoring, and collaboration.

✨ Key Features

🔑 Login & Authentication (via e-PMIS API, US001)

📊 Landing Screen Dashboard
Scrollable project summary cards
Categories: Development, Technical Assistance, Own Fund, Feasibility Studies

📋 Project Management
Project list with ID, title, duration, and status
Project details: cost, allocation, release, expenditure

📷 Image Capture & Upload
Capture with camera
Store locally & sync to e-PMIS server
Manage pending images before upload

🖼️ Image Gallery with metadata (location, time, caption)

📑 Financial Tracking
Allocation details
Release details
Expenditure reports

👥 User & PD Directory
User profile, PD details, messaging & calling options

🚀 Fast Track Projects & Agency-Wise Project Listings

🔔 Notifications & Approvals

🌙 Simple, clean UI with easy navigation

🛠️ Tech Stack

Framework: Flutter 3.x (Dart)
Platforms: Android & iOS

Backend Integration: e-PMIS REST APIs (custom endpoints such as US001, PS025, PS070, RS022, RS028, etc.)
Database/Local Storage: SQLite / Hive (for offline image storage before upload)

CI/CD: GitHub Actions (planned)
Device Features: Camera, Location (GPS), File Storage

📂 Project Structure
lib/
 ├─ main.dart
 ├─ core/          # Config & constants
 ├─ data/          # API services, models
 ├─ ui/            
 │   ├─ screens/   # All screens (Login, Dashboard, etc.)
 │   └─ widgets/   # Reusable UI components
 └─ utils/         # Helpers, formatters

🚀 Getting Started
1. Prerequisites
Flutter SDK (>= 3.x)
Android Studio with Flutter/Dart plugins
iOS 11.0+ or Android 6.0+ device/emulator

2. Installation
# Clone the repo
git clone https://github.com/yourusername/e-pmis-rrpm.git

# Navigate into the project
cd e-pmis-rrpm

# Install dependencies
flutter pub get

# Run the app
flutter run

🧪 API Integration
The application communicates with the e-PMIS backend through a series of APIs:

Screen	API ID	Purpose
Login	US001	User authentication
Dashboard	PS190	Project summary list
Projects	PS090	Retrieve ongoing projects
Project Details	PS025	Fetch detailed info
Cost Details	PS070	Project financials
Allocation	RS022	Allocation data
Release	RS025	Monthly release data
Expenditure	RS028	Monthly expenditure
Gallery	PS272	Fetch uploaded images
Upload	FS002	Upload images
Profile	OMS014	User profile
PD Directory	PS663, PS664, PS665	Ministry, Division, Agency projects
Fast Track	PS193	Fast track projects
All Projects	PS017	All projects listing
Logout	US003	Logout functio
	

👨‍💻 Author

Rokan Uddin (GitHub: IbrarTanim)
📧 Email: rokan.uddin0507@gmail.com
