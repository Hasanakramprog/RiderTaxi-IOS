import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';

class ApiTest {
  // Test Google Maps Geocoding API to verify the API key works
  static Future<bool> testGoogleMapsApiKey() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json'
          '?address=Beirut,Lebanon'
          '&key=${AppConfig.googleMapsApiKey}',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          print('✅ Google Maps API Key is working correctly');
          return true;
        } else {
          print('❌ Google Maps API Error: ${data['status']}');
          print('Error message: ${data['error_message'] ?? 'Unknown error'}');
          return false;
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('❌ Exception testing API key: $e');
      return false;
    }
  }

  // Test if we can get directions (for route calculations)
  static Future<bool> testDirectionsApi() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://maps.googleapis.com/maps/api/directions/json'
          '?origin=33.8938,35.5018' // Beirut coordinates
          '&destination=33.8869,35.5131' // Another point in Beirut
          '&key=${AppConfig.googleMapsApiKey}',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          print('✅ Google Directions API is working correctly');
          return true;
        } else {
          print('❌ Google Directions API Error: ${data['status']}');
          print('Error message: ${data['error_message'] ?? 'Unknown error'}');
          return false;
        }
      } else {
        print('❌ HTTP Error: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('❌ Exception testing Directions API: $e');
      return false;
    }
  }

  // Run all API tests
  static Future<void> runAllTests() async {
    print('🧪 Running Google Maps API tests...');
    print('');

    await testGoogleMapsApiKey();
    await testDirectionsApi();

    print('');
    print('🧪 API tests completed');
  }
}
