import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/game_controller.dart';
import 'views/screens/settings_screen.dart';

void main() {
  runApp(const SkorApp());
}

class SkorApp extends StatelessWidget {
  const SkorApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider di root -> GameController jadi bisa
    // diakses (context.watch / context.read) dari widget mana pun
    // di bawahnya di widget tree, tanpa perlu passing manual lewat
    // constructor tiap widget (menghindari "prop drilling").
    return ChangeNotifierProvider(
      create: (_) => GameController(),
      child: MaterialApp(
        title: 'Skor Pertandingan',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.indigo,
          useMaterial3: true,
        ),
        home: const SettingsScreen(),
      ),
    );
  }
}
