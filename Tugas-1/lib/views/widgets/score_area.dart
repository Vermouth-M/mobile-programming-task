import 'package:flutter/material.dart';

/// VIEW (widget) -- murni tampilan, tidak ada logic permainan di sini.
/// Semua yang widget ini tahu: "kalau ditekan, panggil onTap()".
/// Keputusan "apa yang terjadi setelah ditekan" ada di Controller.
///
/// CATATAN PENTING soal multi-touch:
/// Flutter engine SECARA NATIF mendukung banyak pointer (jari)
/// bersamaan. Yang membuat tap 2 pemain "saling mengganggu" biasanya
/// BUKAN karena keterbatasan Flutter, tapi karena kesalahan desain
/// widget, misalnya:
///   1. Membungkus seluruh layar dengan SATU GestureDetector besar
///      -> hanya ada satu "gesture arena", jadi tap kedua bisa
///         dianggap bagian dari gesture yang sama (mis. jadi terdeteksi
///         sebagai scale/drag, bukan dua tap terpisah).
///   2. Memakai `onTap` yang menunggu proses "tap recognition" (Flutter
///      menunggu pointer diangkat & memastikan bukan drag/long-press)
///      -> menambah delay kecil, terasa kurang responsif untuk game
///         cepat seperti ini.
///
/// Solusi di sini:
///   - Setiap pemain punya widget `Listener` SENDIRI-SENDIRI (lihat
///     GameScreen: dua Expanded, masing-masing dibungkus Listener-nya
///     sendiri). Karena keduanya widget terpisah, Flutter otomatis
///     melacak pointer/jari untuk masing-masing secara independen.
///   - Pakai `onPointerDown` (bukan `onTap`) supaya skor bertambah
///     PERSIS saat jari menyentuh layar, tanpa menunggu jari diangkat
///     atau proses disambiguasi gesture -- respons instan, penting
///     untuk game ketuk-cepat begini.
///   - `behavior: HitTestBehavior.opaque` supaya seluruh area (termasuk
///     bagian yang "kosong"/transparan) tetap bisa menerima sentuhan,
///     bukan cuma bagian yang ada widget visualnya.
class ScoreArea extends StatelessWidget {
  final String playerLabel;
  final int score;
  final Color color;
  final VoidCallback onTap;

  const ScoreArea({
    super.key,
    required this.playerLabel,
    required this.score,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: (_) => onTap(),
      child: Container(
        color: color,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              playerLabel,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '$score',
              style: const TextStyle(
                fontSize: 96,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Ketuk untuk tambah skor',
              style: TextStyle(fontSize: 13, color: Colors.white60),
            ),
          ],
        ),
      ),
    );
  }
}
