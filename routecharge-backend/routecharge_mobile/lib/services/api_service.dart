import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/charging_station.dart';

class ApiService {
  // Base URL pointing to Spring Boot local server
static const String baseUrl = 'http://localhost:8080/api';

  // Fetch all charging stations from backend
  Future<List<ChargingStation>> fetchStations() async {
    final response = await http.get(Uri.parse('$baseUrl/stations'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => ChargingStation.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load charging stations from backend');
    }
  }

  // Fetch nearby stations based on user coordinates
  Future<List<ChargingStation>> fetchNearbyStations(double lat, double lng, {double distanceKm = 10.0}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/stations/nearby?lat=$lat&lng=$lng&distance=$distanceKm'),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => ChargingStation.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load nearby stations');
    }
  }
}