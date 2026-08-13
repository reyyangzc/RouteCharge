import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_theme.dart';
import '../providers/station_provider.dart';

class StationListScreen extends StatelessWidget {
  const StationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Şarj İstasyonları', style: TextStyle(color: AppTheme.primaryGreen)),
      ),
      body: Consumer<StationProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator(color: AppTheme.primaryGreen));
          }

          if (provider.stations.isEmpty) {
            return const Center(child: Text('İstasyon bulunamadı.', style: TextStyle(color: Colors.white)));
          }

          return ListView.builder(
            itemCount: provider.stations.length,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              final station = provider.stations[index];
              return Card(
                color: AppTheme.cardBackground,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Icon(
                    Icons.ev_station,
                    color: station.isFastCharger ? AppTheme.fastChargerOrange : AppTheme.slowChargerBlue,
                    size: 36,
                  ),
                  title: Text(station.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text('${station.operator} • ${station.powerKw} kW', style: const TextStyle(color: AppTheme.textMuted)),
                  trailing: Text(
                    station.isFastCharger ? 'DC' : 'AC',
                    style: TextStyle(
                      color: station.isFastCharger ? AppTheme.fastChargerOrange : AppTheme.slowChargerBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}