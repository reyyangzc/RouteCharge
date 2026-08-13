class ApiConfig {
  // Android Emülatör için: http://10.0.2.2:8080/api
  // iOS Simülatör veya Web için: http://localhost:8080/api
  // Gerçek cihaz testi için bilgisayarının IP adresi (Örn: http://192.168.1.100:8080/api)
  static const String baseUrl = 'http://10.0.2.2:8080/api';

  static const String stations = '$baseUrl/stations';
  static const String nearby = '$baseUrl/stations/nearby';
  static const String search = '$baseUrl/stations/search';
}