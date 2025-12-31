# Housekeeping Service Application

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white)](https://flutter.dev)
[![React](https://img.shields.io/badge/React-61DAFB?style=flat&logo=react&logoColor=black)](https://reactjs.org)
[![Node.js](https://img.shields.io/badge/Node.js-339933?style=flat&logo=node.js&logoColor=white)](https://nodejs.org)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=flat&logo=postgresql&logoColor=white)](https://www.postgresql.org)

A comprehensive mobile and web platform connecting households with professional housekeeping service providers. This application streamlines the process of posting jobs, finding qualified workers, and managing housekeeping services efficiently.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Development](#development)
- [Team](#team)
- [Roadmap](#roadmap)
- [License](#license)

## 🌟 Overview

In an era where the demand for housekeeping services continues to grow, connecting service seekers with qualified workers remains a significant challenge. This application addresses this gap by providing a comprehensive, user-friendly platform that ensures convenience, speed, and security in the hiring and job-seeking process.

### Key Benefits

- **For Households**: Easily post job requirements with detailed descriptions, schedules, budgets, and specific needs
- **For Workers**: Browse suitable job opportunities, apply for positions, and build a professional profile
- **For Everyone**: Real-time messaging, transparent ratings and reviews, and secure payment processing

## ✨ Features

### Mobile Application (iOS & Android)

#### For Job Posters (Households)
- 📝 Post, edit, and delete job listings with detailed requirements
- 👀 View and manage applications from potential workers
- 💬 Direct messaging with workers for detailed discussions
- ⭐ Rate and review workers after job completion
- 🚨 Submit complaints to administrators when issues arise
- 🤖 Chatbot assistance for system guidance and FAQs

#### For Workers
- 🔍 Search and browse available jobs with smart filters
- 📄 Apply for jobs that match skills and availability
- 👤 Manage personal profile and work history
- 📋 Track all job applications and statuses
- 💬 Direct messaging with job posters
- ⭐ Build reputation through ratings and reviews

### Web Admin Panel

- 👥 User management (households and workers)
- 📊 Job listing oversight and moderation
- 📈 Financial analytics and reporting dashboards
- 🏷️ Service category management
- ⚙️ System configuration and settings
- 💰 Payment and transaction management
- 🎫 Complaint handling and resolution
- 🎁 Promotional campaign management

## 🛠️ Technology Stack

### Frontend
- **Mobile**: Flutter (Dart) - Cross-platform development for iOS and Android
- **Web Admin**: ReactJS - Modern, responsive admin dashboard

### Backend
- **Server**: Node.js + Express.js - RESTful API architecture
- **Real-time Features**: Firebase - Push notifications and real-time messaging
- **Chatbot**: Rasa - Conversational AI for user support

### Database
- **PostgreSQL** - Robust relational database for data management

### Development Tools
- **IDE**: Visual Studio Code, Android Studio
- **Version Control**: GitHub
- **Project Management**: Google Docs, Notion
- **Design**: Figma

## 📁 Project Structure

```
SE121_GiupViecApp/
├── FrontEnd/          # Flutter mobile application
├── BackEnd/           # Node.js + Express server
├── admin/             # ReactJS admin web panel
└── README.md          # Project documentation
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Node.js (v14 or higher)
- PostgreSQL (v12 or higher)
- Android Studio / Xcode (for mobile development)
- npm or yarn

### Installation

#### Mobile Application (Flutter)

```bash
# Navigate to the frontend directory
cd FrontEnd

# Install dependencies
flutter pub get

# Run the application
flutter run
```

#### Backend Server (Node.js)

```bash
# Navigate to the backend directory
cd BackEnd

# Install dependencies
npm install

# Configure environment variables
cp .env.example .env
# Edit .env with your database credentials and API keys

# Start the server
npm start
```

#### Admin Web Panel (React)

```bash
# Navigate to the admin directory
cd admin

# Install dependencies
npm install

# Start the development server
npm start
```

The admin panel will be available at `http://localhost:3000`

### Database Setup

```sql
-- Create a new PostgreSQL database
CREATE DATABASE housekeeping_db;

-- Run migrations (specific commands depend on your migration setup)
-- Connect to your database and run initialization scripts
```

## 💻 Development

### Mobile Development

```bash
# Run on specific device
flutter run -d <device_id>

# Build for production
flutter build apk  # Android
flutter build ios  # iOS
```

### API Documentation

The backend API follows RESTful conventions. Key endpoints include:

- `/api/auth` - Authentication and authorization
- `/api/users` - User management
- `/api/jobs` - Job posting and management
- `/api/applications` - Job applications
- `/api/messages` - Real-time messaging
- `/api/reviews` - Ratings and reviews

---

**Note**: This application is developed as a capstone project for SE121 course and is intended for educational purposes.
