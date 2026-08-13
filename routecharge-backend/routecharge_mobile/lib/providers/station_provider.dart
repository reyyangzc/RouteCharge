import 'package:flutter/material.dart';
import 'package:routecharge_mobile/models/charging_station.dart';
import 'package:routecharge_mobile/services/api_service.dart';

class StationProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<ChargingStation> _stations = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<ChargingStation> get stations => _stations;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Filter fast charging stations safely
  List<ChargingStation> get fastStations =>
      _stations.where((s) => s.isFastCharger).toList();

  // Fetch all stations and notify UI listeners
  Future<void> loadStations() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _stations = await _apiService.fetchStations();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}