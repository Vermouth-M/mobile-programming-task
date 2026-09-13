import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/game_controller.dart';
import '../../models/match_model.dart';
import '../widgets/score_area.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  void _showWinnerDialog(BuildContext context, GameController controller) {
    final winner = controller.match.winner;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text('Pemain $winner Menang!'),
        content: Text(
          'Skor akhir: ${controller.match.player1Score} - ${controller.match.player2Score}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              controller.backToSetup();
              Navigator.of(context).pop(); // kembali ke SettingsScreen
            },
            child: const Text('Ubah Setting'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              controller.rematch();
            },
            child: const Text('Main Lagi'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // context.watch<T>() -> subscribe ke Controller. Setiap kali
    // notifyListeners() dipanggil di Controller, build() ini
    // dijalankan ulang otomatis dengan data terbaru.
    final controller = context.watch<GameController>();
    final match = controller.match;

    // Begitu status berubah jadi finished, tampilkan dialog pemenang.
    // addPostFrameCallback dipakai supaya showDialog tidak dipanggil
    // di tengah proses build() (yang tidak diperbolehkan Flutter),
    // melainkan tepat setelah frame ini selesai digambar.
    if (match.status == MatchStatus.finished) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) _showWinnerDialog(context, controller);
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                'Target skor: ${match.maxScore}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            // Dua ScoreArea terpisah, masing-masing punya Listener
            // sendiri (lihat penjelasan di score_area.dart) -> keduanya
            // bisa ditekan secara BERSAMAAN oleh 2 pemain berbeda
            // tanpa saling mengganggu.
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ScoreArea(
                      playerLabel: 'Pemain 1',
                      score: match.player1Score,
                      color: Colors.blue.shade600,
                      onTap: () => controller.addPoint(1),
                    ),
                  ),
                  const VerticalDivider(width: 2, color: Colors.white),
                  Expanded(
                    child: ScoreArea(
                      playerLabel: 'Pemain 2',
                      score: match.player2Score,
                      color: Colors.red.shade600,
                      onTap: () => controller.addPoint(2),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
