class ChargingStation {
  final int id;
  final String name;
  final String operator;
  final String address;
  final double powerKw;
  final bool isFastCharger;
  final double latitude;
  final double longitude;

  ChargingStation({
    required this.id,
    required this.name,
    required this.operator,
    required this.address,
    required this.powerKw,
    required this.isFastCharger,
    required this.latitude,
    required this.longitude,
  });

  factory ChargingStation.fromJson(Map<String, dynamic> json) {
    return ChargingStation(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      operator: json['operator'] ?? '',
      address: json['address'] ?? '',
      powerKw: (json['powerKw'] as num?)?.toDouble() ?? 0.0,
      isFastCharger: json['isFastCharger'] ?? false,
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
    );
  }
}