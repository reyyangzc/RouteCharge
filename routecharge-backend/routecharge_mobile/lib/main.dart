import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/app_theme.dart';
import 'providers/station_provider.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const RouteChargeApp());
}

class RouteChargeApp extends StatelessWidget {
  const RouteChargeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StationProvider()),
      ],
      child: MaterialApp(
        title: 'RouteCharge',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const MainScreen(),
      ),
    );
  }
}