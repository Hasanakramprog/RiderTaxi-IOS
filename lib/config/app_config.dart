class AppConfig {
  // Google Maps API Key
  static const String googleMapsApiKey =
      'AIzaSyBRc3uIObHREcIvZ-Y5gSFzKziM8AEGXog';

  // Firebase Configuration (these are already in firebase_options.dart)
  static const String firebaseProjectId = 'taxiapp-b0cd7';

  // App Constants
  static const String appName = 'Rider App';
  static const String appVersion = '1.0.0';

  // Google Places API configuration
  static const String placesApiKey =
      googleMapsApiKey; // Usually same as Maps API key

  // Directions API configuration
  static const String directionsApiKey =
      googleMapsApiKey; // Usually same as Maps API key
}
