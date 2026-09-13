import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/game_controller.dart';
import 'views/screens/main_menu.dart';

void main() {
  runApp(const SkorApp());
}

class SkorApp extends StatelessWidget {
  const SkorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameController(),
      child: MaterialApp(
        title: 'Skor Pertandingan',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.indigo,
          useMaterial3: true,
        ),
        home: const MainMenuScreen(),
      ),
    );
  }
}
