/// Status pertandingan saat ini.
///
/// `setup`    -> user sedang mengatur max score, belum mulai main.
/// `playing`  -> pertandingan berjalan, tap masih dihitung.
/// `finished` -> salah satu pemain sudah mencapai max score.
enum MatchStatus { setup, playing, finished }

/// MODEL (MVC)
///
/// Kelas ini murni menyimpan DATA pertandingan. Tidak ada logic
/// "nambah skor" atau "cek siapa menang" di sini -- itu tugas
/// Controller. Model hanya bertanggung jawab merepresentasikan
/// bentuk data secara konsisten.
///
/// Dibuat immutable (semua field `final`) dan pakai `copyWith`
/// supaya setiap perubahan state menghasilkan objek baru yang jelas
/// -- pola umum di Flutter agar gampang di-debug (bisa lihat histori
/// state) dan menghindari bug "state berubah diam-diam" di tempat
/// yang tidak terduga.
class MatchModel {
  final int maxScore;
  final int player1Score;
  final int player2Score;
  final MatchStatus status;

  const MatchModel({
    required this.maxScore,
    this.player1Score = 0,
    this.player2Score = 0,
    this.status = MatchStatus.setup,
  });

  /// Pemenang saat ini: 1, 2, atau null kalau belum ada/belum selesai.
  int? get winner {
    if (status != MatchStatus.finished) return null;
    if (player1Score >= maxScore) return 1;
    if (player2Score >= maxScore) return 2;
    return null;
  }

  MatchModel copyWith({
    int? maxScore,
    int? player1Score,
    int? player2Score,
    MatchStatus? status,
  }) {
    return MatchModel(
      maxScore: maxScore ?? this.maxScore,
      player1Score: player1Score ?? this.player1Score,
      player2Score: player2Score ?? this.player2Score,
      status: status ?? this.status,
    );
  }
}
