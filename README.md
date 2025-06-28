# Rider App

A modern Flutter mobile application with Firebase integration, featuring real-time data synchronization and a clean, intuitive counter interface.

## Features

- **Firebase Integration**: Connected to existing Firebase project (taxiapp-b0cd7)
- **Real-time Database**: Live data synchronization with Firestore
- **Material Design 3**: Modern UI following Google's latest design guidelines
- **Counter Functionality**: Increment, decrement, and reset counter with Firebase persistence
- **Responsive Design**: Optimized for various screen sizes
- **Clean Architecture**: Well-structured code following Flutter best practices
- **Cross-platform Support**: Android, iOS, Web, macOS, and Windows

## Firebase Services Included

- **Firestore**: Real-time database for data persistence
- **Firebase Core**: Essential Firebase functionality
- **Firebase Analytics**: User behavior tracking (configured)
- **Firebase Auth**: Authentication services (configured for future use)

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (included with Flutter)
- An IDE (VS Code, Android Studio, or IntelliJ)
- iOS Simulator/Android Emulator or physical device
- Firebase project access (currently connected to taxiapp-b0cd7)

### Installation

1. **Clone or download this project**
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

### Development

- **Hot Reload**: Save your changes to see them instantly in the app
- **Debug Mode**: Use `flutter run` for development with debugging enabled
- **Release Mode**: Use `flutter run --release` for optimized performance

## Project Structure

```
lib/
├── main.dart              # Entry point and main app configuration
├── firebase_options.dart  # Firebase configuration (auto-generated)
├── screens/               # Screen widgets
│   └── home_screen.dart   # Main home screen with counter
├── widgets/               # Reusable UI components
│   └── counter_widgets.dart # Counter display and action widgets
├── models/                # Data models
│   └── ride_request.dart  # Example model for future taxi functionality
└── services/              # Business logic and API services
    └── firebase_service.dart # Firebase database operations
```

## Firebase Configuration

The app is configured to work with multiple platforms:
- **Web**: Firebase web app
- **Android**: Android app package
- **iOS**: iOS app bundle
- **macOS**: macOS app bundle  
- **Windows**: Windows app package

Firebase configuration is automatically managed through `lib/firebase_options.dart`.

## Database Structure

The app uses Firestore with the following collections:
- `counter/main_counter`: Stores the global counter value
- `ride_requests/`: Reserved for future taxi booking functionality

## Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Testing

Run tests with:
```bash
flutter test
```

## Next Steps for Taxi App Development

The app is prepared for taxi/ride-sharing functionality with:
- Firebase service methods for ride requests
- Data models for ride management
- Scalable architecture for feature expansion

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Firebase for Flutter](https://firebase.google.com/docs/flutter/setup)
- [Material Design 3](https://m3.material.io/)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
