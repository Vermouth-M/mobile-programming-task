import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/pahlawan_controller.dart';
import 'utils/app_theme.dart';
import 'views/screens/main_navigation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PahlawanNasionalApp());
}

class PahlawanNasionalApp extends StatelessWidget {
  const PahlawanNasionalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PahlawanController(),
      child: MaterialApp(
        title: 'Informasi Pahlawan Nasional',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const MainNavigationScreen(),
      ),
    );
  }
}
