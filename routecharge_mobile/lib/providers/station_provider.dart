import 'package:flutter/material.dart';
import '../models/charging_station.dart';
import '../services/station_api_service.dart';

enum StationFilter { all, fastOnly, nearby }

class StationProvider extends ChangeNotifier {
  final StationApiService _apiService = StationApiService();

  List<ChargingStation> _stations = [];
  List<ChargingStation> get stations => _filteredStations();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  StationFilter _currentFilter = StationFilter.all;
  StationFilter get currentFilter => _currentFilter;

  ChargingStation? _selectedStation;
  ChargingStation? get selectedStation => _selectedStation;

  Future<void> fetchStations() async {
    _setLoading(true);
    try {
      _stations = await _apiService.fetchAllStations();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'İstasyonlar yüklenirken bir hata oluştu: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchNearbyStations(double lat, double lng) async {
    _setLoading(true);
    try {
      _stations = await _apiService.fetchNearbyStations(lat, lng);
      _currentFilter = StationFilter.nearby;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Yakındaki istasyonlar alınamadı: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> searchStations(String query) async {
    if (query.trim().isEmpty) {
      fetchStations();
      return;
    }
    _setLoading(true);
    try {
      _stations = await _apiService.searchStations(query);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Arama yapılırken hata oluştu: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> addStation(ChargingStation station) async {
    try {
      final newStation = await _apiService.createStation(station);
      _stations.add(newStation);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'İstasyon eklenemedi: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateStation(int id, ChargingStation station) async {
    try {
      final updated = await _apiService.updateStation(id, station);
      int index = _stations.indexWhere((s) => s.id == id);
      if (index != -1) {
        _stations[index] = updated;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _errorMessage = 'İstasyon güncellenemedi: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteStation(int id) async {
    try {
      await _apiService.deleteStation(id);
      _stations.removeWhere((s) => s.id == id);
      if (_selectedStation?.id == id) {
        _selectedStation = null;
      }
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'İstasyon silinemedi: $e';
      notifyListeners();
      return false;
    }
  }

  void setFilter(StationFilter filter) {
    _currentFilter = filter;
    notifyListeners();
  }

  void selectStation(ChargingStation? station) {
    _selectedStation = station;
    notifyListeners();
  }

  List<ChargingStation> _filteredStations() {
    if (_currentFilter == StationFilter.fastOnly) {
      return _stations.where((s) => s.isFastCharger).toList();
    }
    return _stations;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}