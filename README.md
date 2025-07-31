# PixelArt iOS App

A collaborative pixel art creation and competition platform built with SwiftUI and Firebase.

## 🎨 Overview

PixelArt is an iOS application that allows users to create pixel art, participate in themed competitions, and share their artwork with the community. The app features a real-time drawing canvas, competition system, social features like following and liking, and offline-first capabilities.

## ✨ Features

### 🖌️ Drawing & Creation
- **Pixel Canvas**: Interactive drawing canvas with customizable grid sizes
- **Color Palette**: Predefined color palettes for competitions and free drawing
- **Drawing Tools**: Pencil, eraser, and grid toggle functionality
- **Zoom & Pan**: Intuitive canvas navigation with pinch-to-zoom and pan gestures
- **Real-time Updates**: Live pixel changes with smooth performance

### 🏆 Competition System
- **Themed Competitions**: Participate in time-limited competitions with specific topics
- **Color Constraints**: Use predefined color palettes for fair competition
- **Scoring Phase**: Vote and rate other participants' artwork
- **Timer System**: Real-time countdown for competition phases
- **Past Competitions**: Browse and view historical competition results

### 👥 Social Features
- **User Profiles**: Customizable profiles with pixel art avatars
- **Follow System**: Follow other artists and see their latest work
- **Like System**: Like and appreciate artwork from the community
- **User Discovery**: Browse and discover new artists
- **Activity Feed**: View recent artwork from followed users

### 🔄 Offline-First Architecture
- **Core Data Integration**: Local storage for artwork and user data
- **Sync Management**: Automatic synchronization when online
- **Offline Creation**: Create artwork without internet connection
- **Conflict Resolution**: Smart handling of data conflicts

### 🎯 User Experience
- **Pixel Art Aesthetic**: Consistent pixel art theme throughout the app
- **Custom Fonts**: Micro5 pixel font for authentic retro feel
- **Smooth Navigation**: Tab-based navigation with custom pixel-style UI
- **Network Awareness**: Graceful handling of connectivity issues

## 🏗️ Architecture

### Core Structure
```
PixelArt/
├── Core/                 # Business logic and data models
│   ├── AppUser/         # User management
│   ├── Artwork/         # Artwork models and services
│   ├── Competition/     # Competition system
│   ├── Auth/           # Authentication
│   ├── DataSync/       # Synchronization logic
│   └── Navigation/     # Routing system
├── Features/            # Feature-specific views and view models
│   ├── DrawingCanvas/  # Drawing functionality
│   ├── Competition/    # Competition UI
│   ├── Profile/        # User profiles
│   └── Artworks/       # Artwork gallery
├── Shared/             # Shared utilities and components
│   ├── UI/            # Reusable UI components
│   ├── Extensions/    # Swift extensions
│   └── Constants/     # App constants
└── Resources/         # Assets, fonts, and data models
```

### Key Technologies
- **SwiftUI**: Modern declarative UI framework
- **Firebase**: Backend services (Auth, Firestore, Cloud Functions)
- **Core Data**: Local data persistence
- **UIKit Integration**: Custom drawing canvas implementation


## 📱 App Structure

### Main Tabs
1. **Competition**: Active competitions, voting, and results
2. **Artworks**: Personal and community artwork gallery
3. **Profile**: User profile, settings, and social features

### Key Views
- **DrawingCanvas**: Main drawing interface
- **CompetitionView**: Competition participation and voting
- **ProfileView**: User profile and settings
- **ArtworksView**: Artwork gallery and discovery

## 🔧 Development

### Project Structure
The project follows a clean architecture pattern with clear separation of concerns:

- **Models**: Data structures and business logic
- **Services**: Business logic and external integrations
- **Repositories**: Data access layer
- **ViewModels**: UI logic and state management
- **Views**: SwiftUI user interface components

### Key Patterns
- **MVVM**: Model-View-ViewModel architecture
- **Repository Pattern**: Abstracted data access
- **Dependency Injection**: Service injection for testability
- **Protocol-Oriented Programming**: Interface-based design


## 🎨 Customization

### Themes
The app uses a consistent pixel art theme with:
- Custom pixel fonts (Micro5)
- Pixel-style UI components
- Retro color schemes
- Custom button and background modifiers

### Drawing Tools
The drawing canvas supports:
- Multiple grid sizes (16x16, 32x32, 33x33, etc.)
- Custom color palettes
- Various drawing operations
- Real-time collaboration features


## Screenshots app screens
### Competition
<img width="1320" height="557" alt="Image" src="https://github.com/user-attachments/assets/df086e40-95a4-4e66-862c-b6745e188326" />

### Scoring & Voting

<img width="1058" height="557" alt="Image" src="https://github.com/user-attachments/assets/6f98090a-c6d9-4ab5-89c4-c550ec79f42f" />

### Past competitions & Result

<img width="1058" height="555" alt="Image" src="https://github.com/user-attachments/assets/3dec28e6-269c-4108-8899-a7349b7c1a7c" />

### Artworks

<img width="1843" height="555" alt="Image" src="https://github.com/user-attachments/assets/df6bc98f-c4a1-44db-a22d-61f3b6e0ffdf" />

### Drawing canvas

<img width="1578" height="555" alt="Image" src="https://github.com/user-attachments/assets/8299af8b-d8e6-4cd5-82f7-1c79409250c8" />

### Profile & Social screens

<img width="1840" height="555" alt="Image" src="https://github.com/user-attachments/assets/c3a5ae1b-212e-454f-88b4-8bc7a5bc3726" />
