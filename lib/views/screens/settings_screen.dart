import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/game_controller.dart';
import 'game_screen.dart';

/// VIEW -- StatefulWidget karena butuh menyimpan nilai TextField
/// SEMENTARA (sebelum ditekan "Mulai"). Ini state lokal UI, bukan
/// state permainan -- makanya boleh pakai setState biasa di sini,
/// tidak perlu lewat Controller.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _maxScoreController =
      TextEditingController(text: '11');
  String? _errorText;

  @override
  void dispose() {
    // Wajib: TextEditingController harus di-dispose supaya tidak
    // membocorkan memory saat widget ini dibuang dari widget tree.
    _maxScoreController.dispose();
    super.dispose();
  }

  void _startGame() {
    final input = int.tryParse(_maxScoreController.text.trim());

    if (input == null || input <= 0) {
      setState(() => _errorText = 'Masukkan angka lebih besar dari 0');
      return;
    }

    // context.read<T>() -> ambil Controller SEKALI untuk memanggil
    // method (tidak "subscribe"/mendengarkan perubahan). Dipakai saat
    // aksi sesaat seperti ini (beda dengan context.watch yang dipakai
    // di build() untuk ikut me-render ulang saat data berubah).
    context.read<GameController>().setMaxScoreAndStart(input);

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const GameScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan Pertandingan')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Skor Maksimum',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pemain yang lebih dulu mencapai angka ini akan menang.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _maxScoreController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 28),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                errorText: _errorText,
                hintText: 'mis. 11, 21, 100',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _startGame,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Mulai Pertandingan', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}
