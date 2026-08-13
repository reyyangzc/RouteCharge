import 'package:flutter/material.dart';
import '../config/app_theme.dart';

class StationFormScreen extends StatelessWidget {
  const StationFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('İstasyon Formu', style: TextStyle(color: AppTheme.primaryGreen))),
      body: const Center(child: Text('Form Ekranı', style: TextStyle(color: Colors.white))),
    );
  }
}