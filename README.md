# Skor Game
Game pencatatan skor pertandingan untuk 2 pemain, dibangun dengan **Flutter**. Pengguna bisa mengatur skor maksimum terlebih dahulu, lalu kedua pemain menekan area masing-masing di layar yang sama untuk menambah skor secara **real-time**

## Anggota Kelompok
| No | Nama | NRP |
|----|------|-----|
| 1  |  Nicholas Benaya    |  5024241050   |
| 2  |   Jordi   |  5024241029   |
| 3  |   Devi Putri Sekar Arum   |  5024241049   |
| 4  |   Fito Dwi Ardiansah   |  5024241053   |
| 5  |   Muhamad Risqi Aditiya   |  5024221010   |

## Fitur
-
- **Setting skor maksimum** sebelum pertandingan dimulai.
- **Dua area sentuh independen** (kiri untuk Pemain 1, kanan untuk Pemain 2) yang bisa ditekan **bersamaan**
- **Dialog Winner otomatis** begitu salah satu pemain mencapai skor maksimum, menampilkan skor akhir.
- **Main lagi (rematch)** dengan target skor yang sama, atau **kembali ke pengaturan** untuk mengubah target skor.

## Struktur Folder

```
lib/
├── main.dart
├── ├── assets/
    │   ├── images/
    │   │   ├── Exit.png
    │   │   ├── PLAY.png
    │   │   ├── OPTIONS.png
    │   │   ├── logo.png
    │   │   ├── bg_main_menu.png
├── models/
│   └── match_model.dart          # Data pertandingan (skor, status, max score)
├── controllers/
│   └── game_controller.dart      # Semua aturan permainan
└── views/
    ├── screens/
        ├── main_menu.dart
    │   ├── settings_screen.dart  # Input skor maksimum sebelum mulai
    │   └── game_screen.dart      # Layar pertandingan + dialog pemenang
    └── widgets/
        └── score_area.dart       # Widget area skor per pemain (tap-to-add-point function)
```

## Instalasi & Menjalankan

### Prasyarat
- [Flutter SDK](https://docs.flutter.dev/get-started/install) versi yang mendukung Dart `>=3.0.0`
- Flutter Web

### Langkah

```bash
# 1. Clone repository
git clone https://github.com/nicholasbenaya/mobile-programming-task.git
cd mobile-programming-task

# 2. Ambil dependencies
flutter pub get

# 3. Jalankan aplikasi
flutter run
```

## Dependencies Utama

| Package | Kegunaan |
|---|---|
| [`provider`](https://pub.dev/packages/provider) | State management ringan untuk menghubungkan Controller ke View tanpa passing data manual antar widget |
| `cupertino_icons` | Ikon bergaya iOS |
| `flutter_lints` | Aturan lint standar untuk menjaga kualitas kode |

## Cara Pakai

1. Buka aplikasi → klik tombol **Play**
2. masukkan **skor maksimum** di halaman Pengaturan.
3. Tekan **"Mulai Pertandingan"**.
4. Setiap pemain menekan area warnanya masing-masing (biru = Pemain 1, merah = Pemain 2) untuk menambah skor satu poin per ketukan.
5. Begitu salah satu pemain mencapai skor maksimum, dialog pemenang muncul dengan pilihan **Main Lagi** atau **Ubah Setting**.
