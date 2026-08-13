class ChargingStation {
  final int id;
  final String? name;
  final String? operator;
  final String? address;
  final int? powerKw;
  final bool? isFastCharger;
  final double? latitude;
  final double? longitude;

  const ChargingStation({
    required this.id,
    this.name,
    this.operator,
    this.address,
    this.powerKw,
    this.isFastCharger,
    this.latitude,
    this.longitude,
  });

  factory ChargingStation.fromJson(Map<String, dynamic> json) {
    final coords = _parseLocation(json['location']);
    return ChargingStation(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      operator: json['operator'] as String?,
      address: json['address'] as String?,
      powerKw: json['powerKw'] != null ? (json['powerKw'] as num).toInt() : null,
      isFastCharger: json['isFastCharger'] as bool?,
      latitude: coords?.$1,
      longitude: coords?.$2,
    );
  }

  /// JTS Point farklı formatlarda gelebilir; hepsini destekler
  static (double, double)? _parseLocation(dynamic location) {
    if (location == null) return null;

    if (location is Map<String, dynamic>) {
      // GeoJSON: { "type": "Point", "coordinates": [lng, lat] }
      if (location['coordinates'] is List) {
        final coords = location['coordinates'] as List;
        if (coords.length >= 2) {
          return ((coords[1] as num).toDouble(), (coords[0] as num).toDouble());
        }
      }
      // x/y formatı
      if (location['y'] != null && location['x'] != null) {
        return (
          (location['y'] as num).toDouble(),
          (location['x'] as num).toDouble(),
        );
      }
    }

    return null;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'operator': operator,
        'address': address,
        'powerKw': powerKw,
        'isFastCharger': isFastCharger,
      };

  bool get hasLocation => latitude != null && longitude != null;

  String get displayName => name ?? 'İsimsiz İstasyon';

  String get displayOperator => operator ?? 'Bilinmeyen Operatör';
}
