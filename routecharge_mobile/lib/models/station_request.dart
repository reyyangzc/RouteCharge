class StationRequest {
  final String? name;
  final String? operator;
  final String? address;
  final int? powerKw;
  final bool? isFastCharger;
  final double? latitude;
  final double? longitude;

  const StationRequest({
    this.name,
    this.operator,
    this.address,
    this.powerKw,
    this.isFastCharger,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'operator': operator,
        'address': address,
        'powerKw': powerKw,
        'isFastCharger': isFastCharger,
        'latitude': latitude,
        'longitude': longitude,
      };

  factory StationRequest.fromStation({
    required String? name,
    required String? operator,
    required String? address,
    required int? powerKw,
    required bool? isFastCharger,
    required double? latitude,
    required double? longitude,
  }) {
    return StationRequest(
      name: name,
      operator: operator,
      address: address,
      powerKw: powerKw,
      isFastCharger: isFastCharger,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
