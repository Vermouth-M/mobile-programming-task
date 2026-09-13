import 'package:flutter/foundation.dart';
import '../models/match_model.dart';

/// CONTROLLER (MVC)
///
/// `ChangeNotifier` adalah kelas bawaan Flutter yang punya method
/// `notifyListeners()`. Widget yang "subscribe" ke kelas ini (lewat
/// package `provider`) akan otomatis rebuild setiap kali method
/// tersebut dipanggil. Ini menggantikan `setState` manual di dalam
/// widget, sehingga logic-nya bisa dipisah total dari UI (View
/// jadi "bodoh", cuma nampilin data dan manggil method).
///
/// Semua ATURAN PERMAINAN ada di sini, bukan di widget:
/// - berapa max score
/// - apa yang terjadi saat pemain menekan area-nya
/// - kapan status berubah jadi "finished"
/// - bagaimana cara reset
class GameController extends ChangeNotifier {
  MatchModel _match = const MatchModel(maxScore: 11);

  MatchModel get match => _match;

  /// Dipanggil dari halaman Setting sebelum permainan dimulai.
  void setMaxScoreAndStart(int maxScore) {
    _match = MatchModel(maxScore: maxScore, status: MatchStatus.playing);
    notifyListeners();
  }

  /// Dipanggil setiap kali area pemain 1 atau 2 ditekan.
  /// `player` bernilai 1 atau 2.
  void addPoint(int player) {
    // Guard: kalau match sudah selesai, tap diabaikan supaya skor
    // tidak terus bertambah setelah ada pemenang.
    if (_match.status != MatchStatus.playing) return;

    final newP1 = player == 1 ? _match.player1Score + 1 : _match.player1Score;
    final newP2 = player == 2 ? _match.player2Score + 1 : _match.player2Score;

    final isFinished = newP1 >= _match.maxScore || newP2 >= _match.maxScore;

    _match = _match.copyWith(
      player1Score: newP1,
      player2Score: newP2,
      status: isFinished ? MatchStatus.finished : MatchStatus.playing,
    );
    notifyListeners();
  }

  /// Main ulang dengan max score yang sama, skor kembali 0-0.
  void rematch() {
    _match = MatchModel(maxScore: _match.maxScore, status: MatchStatus.playing);
    notifyListeners();
  }

  /// Kembali ke halaman setting untuk ubah max score dari awal.
  void backToSetup() {
    _match = MatchModel(maxScore: _match.maxScore, status: MatchStatus.setup);
    notifyListeners();
  }
}
