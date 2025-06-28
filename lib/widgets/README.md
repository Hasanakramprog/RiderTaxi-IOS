# Simple Map Widget

A collection of simple, reusable Google Maps widgets for Flutter with Firebase integration.

## Widgets Included

### 1. SimpleMapWidget
A basic Google Maps widget with customizable options.

```dart
SimpleMapWidget(
  height: 300.0,
  initialLocation: LatLng(37.7749, -122.4194),
  onMapTap: (LatLng location) {
    print('Tapped at: $location');
  },
  markers: markers,
  showMyLocationButton: true,
  showZoomControls: true,
)
```

**Features:**
- Customizable height
- Initial location setting
- Tap event handling
- Marker display
- My location button
- Zoom controls
- Modern Material Design 3 styling

### 2. MapWithLocationPicker
A full-screen map for picking locations with address display.

```dart
MapWithLocationPicker(
  title: 'Select Location',
  initialLocation: LatLng(37.7749, -122.4194),
  onLocationSelected: (location, address) {
    print('Selected: $location, Address: $address');
  },
)
```

**Features:**
- Full-screen map interface
- Draggable marker
- Address display
- Confirm/cancel actions
- My location button

### 3. MiniMapWidget
A compact map widget for displaying a single location.

```dart
MiniMapWidget(
  location: LatLng(37.7749, -122.4194),
  height: 150.0,
  showMarker: true,
)
```

**Features:**
- Compact size
- Single location focus
- Optional marker display
- No interaction controls

## Demo Screen

Access the map demo through the home screen's "Map Demo" button to see:

- Interactive map with tap-to-add markers
- Location picker integration
- Mini map dialog
- Demo marker placement
- Real-time location updates

## Google Maps API Key Configuration

The widgets are configured to use your Google Maps API key from `AppConfig.googleMapsApiKey`. Make sure your API key is properly set in:

1. **Android**: `android/app/src/main/AndroidManifest.xml`
2. **iOS**: `ios/Runner/Info.plist`
3. **App Config**: `lib/config/app_config.dart`

## Required Permissions

### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

### iOS (`ios/Runner/Info.plist`)
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to show your position on the map.</string>
```

## Dependencies

- `google_maps_flutter`: For map display
- `provider`: For state management
- `location`: For location services

## Integration with MapProvider

The widgets integrate seamlessly with the existing `MapProvider` for:
- Current user location
- Location initialization
- State management
- Firebase integration
