import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_theme.dart';
import '../providers/station_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'İstasyon veya operatör ara...',
            hintStyle: TextStyle(color: AppTheme.textMuted),
            border: InputBorder.none,
          ),
          onChanged: (val) {
            provider.searchStations(val);
          },
        ),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryGreen))
          : ListView.builder(
              itemCount: provider.stations.length,
              itemBuilder: (context, index) {
                final station = provider.stations[index];
                return ListTile(
                  title: Text(station.name, style: const TextStyle(color: Colors.white)),
                  subtitle: Text(station.address, style: const TextStyle(color: AppTheme.textMuted)),
                );
              },
            ),
    );
  }
}