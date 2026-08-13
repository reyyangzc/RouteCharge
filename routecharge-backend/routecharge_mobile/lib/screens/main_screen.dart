import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../config/app_theme.dart';
import '../models/charging_station.dart';
import '../providers/station_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final MapController _mapController = MapController();
  ChargingStation? _selectedStation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StationProvider>().loadStations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StationProvider>();

    return Scaffold(
      body: Stack(
        children: [
          // OpenStreetMap Container
          FlutterMap(
            mapController: _mapController,
            options: const MapOptions(
              initialCenter: LatLng(41.0082, 28.9784), // Default: Istanbul
              initialZoom: 12.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.routecharge.app',
              ),
              MarkerLayer(
                markers: provider.stations.map((station) {
                  return Marker(
                    width: 40.0,
                    height: 40.0,
                    point: LatLng(station.latitude, station.longitude),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedStation = station;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: station.isFastCharger
                              ? AppTheme.primaryNeon
                              : Colors.orange,
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.ev_station,
                          color: station.isFastCharger
                              ? Colors.black
                              : Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // Loading Indicator Overlay
          if (provider.isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: AppTheme.primaryNeon,
              ),
            ),

          // Selected Station Bottom Sheet Card
          if (_selectedStation != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _selectedStation!.isFastCharger
                        ? AppTheme.primaryNeon
                        : Colors.orange,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            _selectedStation!.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            setState(() {
                              _selectedStation = null;
                            });
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _selectedStation!.address,
                      style: const TextStyle(
                        color: AppTheme.textMuted,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Chip(
                          backgroundColor: _selectedStation!.isFastCharger
                              ? AppTheme.primaryNeon.withOpacity(0.2)
                              : Colors.orange.withOpacity(0.2),
                          label: Text(
                            _selectedStation!.isFastCharger
                                ? 'DC Hızlı Şarj'
                                : 'AC Yavaş Şarj',
                            style: TextStyle(
                              color: _selectedStation!.isFastCharger
                                  ? AppTheme.primaryNeon
                                  : Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${_selectedStation!.powerKw} kW',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}