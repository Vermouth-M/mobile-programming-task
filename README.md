# Mobile Programming Task

Repository ini berisi kumpulan tugas pemrograman mobile. Setiap tugas dibuat sebagai proyek Flutter mandiri, sehingga source code, asset, dependency, dan konfigurasi masing-masing tugas tidak saling berbagi.

## Anggota Kelompok

| No | Nama | NRP |
|----|------|-----|
| 1  | Nicholas Benaya | 5024241050 |
| 2  | Jordi | 5024241029 |
| 3  | Devi Putri Sekar Arum | 5024241049 |
| 4  | Fito Dwi Ardiansah | 5024241053 |
| 5  | Muhamad Risqi Aditiya | 5024221010 |

## Panduan Membaca Repository

README di root ini berisi informasi umum repository dan anggota kelompok. Setiap folder tugas memiliki nested README yang berfungsi sebagai laporan resmi untuk project tersebut.

Assessor dapat merujuk ke nested README di dalam folder tugas untuk melihat tujuan, fitur, struktur kode, dependency, instruksi menjalankan, dan informasi teknis project secara lengkap. Dengan demikian, informasi anggota kelompok cukup dipelihara di README root dan tidak perlu diulang pada setiap laporan project.

## Prasyarat

- Flutter SDK terpasang dan dapat dijalankan dari terminal.
- Dart SDK mengikuti versi yang disertakan oleh Flutter.
- Device atau browser yang mendukung Flutter.

Cek instalasi Flutter dengan:

```bash
flutter doctor
```

## Setelah Clone

Clone repository lalu masuk ke folder repository:

```bash
git clone https://github.com/nicholasbenaya/mobile-programming-task.git
cd mobile-programming-task
```

Setiap tugas memiliki folder sendiri. Jalankan perintah Flutter dari folder tugas yang ingin digunakan.

## Menjalankan Tugas 1

Tugas 1 adalah aplikasi skor pertandingan 2 pemain.

```bash
cd Tugas-1
flutter pub get
flutter run
```

Untuk menjalankan Tugas 1 di browser Chrome:

```bash
flutter run -d chrome
```

Untuk kembali ke root repository setelah selesai:

```bash
cd ..
```

Laporan project dan dokumentasi khusus aplikasi skor tersedia di [`Tugas-1/README.md`](Tugas-1/README.md).

## Struktur Repository

```text
.
├── Tugas-1/
│   ├── assets/       # Asset khusus Tugas-1
│   ├── lib/          # Source code Tugas-1
│   ├── web/          # Konfigurasi Flutter Web Tugas-1
│   ├── pubspec.yaml  # Dependency dan konfigurasi Tugas-1
│   └── README.md     # Dokumentasi detail Tugas-1
└── README.md         # Panduan umum repository
```

## Menambahkan Tugas Berikutnya

Buat setiap tugas sebagai folder Flutter terpisah, misalnya:

```text
Tugas-2/
├── assets/
├── lib/
├── pubspec.yaml
└── README.md
```

Lalu jalankan perintah dari folder tugas tersebut:

```bash
cd Tugas-2
flutter pub get
flutter run
```
