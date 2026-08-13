import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class StationDetailScreen extends StatelessWidget {
  const StationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('İstasyon Detayı', style: TextStyle(color: AppTheme.primaryGreen))),
      body: const Center(child: Text('Detay Ekranı', style: TextStyle(color: Colors.white))),
    );
  }
}