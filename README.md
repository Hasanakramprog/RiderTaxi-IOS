# Ismail Taxi - Rider App 🚕

A modern Flutter-based taxi booking app with real-time location tracking, Firebase integration, and Google Maps support.

## 📱 Features

- **Easy Taxi Booking** - Book rides with just a few taps
- **Real-time Location Tracking** - Live GPS tracking of your ride
- **Multiple Payment Options** - Flexible payment methods
- **Rate Your Driver** - Provide feedback and ratings
- **Quick Ride Booking** - Fast and efficient booking system
- **Safe & Secure Rides** - Trusted and verified drivers
- **Trip History** - View all your past rides
- **Push Notifications** - Stay updated with ride status

## 🏗️ Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase (Firestore, Authentication, Cloud Functions)
- **Maps**: Google Maps API
- **State Management**: Provider
- **Location Services**: Geolocator
- **Real-time Database**: Cloud Firestore

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Firebase project setup
- Google Maps API key

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/ismail-taxi-rider-app.git
   cd ismail-taxi-rider-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a Firebase project
   - Add Android and iOS apps to your Firebase project
   - Download and place `google-services.json` in `android/app/`
   - Download and place `GoogleService-Info.plist` in `ios/Runner/`

4. **Google Maps API Setup**
   - Get Google Maps API key from Google Cloud Console
   - Add the API key to `android/app/src/main/AndroidManifest.xml`
   - Add the API key to `ios/Runner/Info.plist`

5. **Run the app**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── config/           # App configuration
├── models/           # Data models
├── providers/        # State management
├── screens/          # UI screens
├── services/         # Business logic and API calls
├── widgets/          # Reusable UI components
└── utils/           # Utility functions
```

## 🔧 Configuration

### Firebase Configuration
Make sure to update the following files with your Firebase configuration:
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `lib/firebase_options.dart`

### Google Maps API Keys
Add your Google Maps API keys to:
- `android/app/src/main/AndroidManifest.xml`
- `ios/Runner/Info.plist`

## 🎨 UI/UX

The app features a modern Material Design 3 interface with:
- Amber color scheme for branding
- Smooth animations and transitions
- Responsive design for all screen sizes
- Intuitive user experience

## 🔐 Security

- Firebase Authentication for secure user management
- Firestore security rules for data protection
- Location data encryption
- Secure payment integration ready

## 📱 Platform Support

- ✅ Android (API 21+)
- ✅ iOS (iOS 12.0+)
- 🔄 Web (In development)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Developer

**Developed by MK Pro**
- Professional Mobile App Development
- Specialized in Flutter & Firebase solutions

## 📞 Support

For support and inquiries, please contact:
- Email: support@mkpro.dev
- Website: https://mkpro.dev

## 🏆 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Google Maps for location services
- Material Design for UI guidelines

---

**Version**: 1.0.0  
**Built with**: Flutter & Firebase  
**Copyright**: © 2025 MK Pro. All rights reserved.
