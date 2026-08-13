import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/charging_station.dart';

class StationApiService {
  Future<List<ChargingStation>> fetchAllStations() async {
    final response = await http.get(Uri.parse(ApiConfig.stations));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      return body.map((json) => ChargingStation.fromJson(json)).toList();
    } else {
      throw Exception('İstasyonlar yüklenemedi');
    }
  }

  Future<List<ChargingStation>> fetchNearbyStations(
      double lat, double lng, {double distanceMeters = 10000}) async {
    final uri = Uri.parse(
        '${ApiConfig.nearby}?latitude=$lat&longitude=$lng&distanceMeters=$distanceMeters');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      return body.map((json) => ChargingStation.fromJson(json)).toList();
    } else {
      throw Exception('Yakındaki istasyonlar alınamadı');
    }
  }

  Future<List<ChargingStation>> searchStations(String query) async {
    final uri = Uri.parse('${ApiConfig.search}?query=$query');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      return body.map((json) => ChargingStation.fromJson(json)).toList();
    } else {
      throw Exception('Arama sonucu alınamadı');
    }
  }

  Future<ChargingStation> createStation(ChargingStation station) async {
    final response = await http.post(
      Uri.parse(ApiConfig.stations),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(station.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ChargingStation.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('İstasyon eklenemedi');
    }
  }

  Future<ChargingStation> updateStation(int id, ChargingStation station) async {
    final response = await http.put(
      Uri.parse('${ApiConfig.stations}/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(station.toJson()),
    );

    if (response.statusCode == 200) {
      return ChargingStation.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('İstasyon güncellenemedi');
    }
  }

  Future<void> deleteStation(int id) async {
    final response = await http.delete(Uri.parse('${ApiConfig.stations}/$id'));

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('İstasyon silinemedi');
    }
  }
}