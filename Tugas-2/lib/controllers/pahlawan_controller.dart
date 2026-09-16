import 'package:flutter/foundation.dart';
import '../models/hero_model.dart';
import '../data/hero_data.dart';

enum HeroSortMode {
  nameAsc,
  nameDesc,
  birthYearAsc,
  birthYearDesc,
}

class PahlawanController extends ChangeNotifier {
  final List<HeroModel> _heroes = List.unmodifiable(HeroData.heroes);

  String _searchQuery = '';
  String _selectedRegion = 'Semua';
  String _selectedEra = 'Semua';
  HeroSortMode _sortMode = HeroSortMode.nameAsc;
  final Set<String> _favoriteIds = {'soekarno', 'soedirman'}; // default initial favorites

  // Getters
  List<HeroModel> get allHeroes => _heroes;
  String get searchQuery => _searchQuery;
  String get selectedRegion => _selectedRegion;
  String get selectedEra => _selectedEra;
  HeroSortMode get sortMode => _sortMode;
  Set<String> get favoriteIds => _favoriteIds;

  List<String> get availableRegions => [
        'Semua',
        'Jawa',
        'Sumatera',
        'Maluku',
        'Sulawesi',
        'Bali & Nusa',
        'Papua',
      ];

  List<String> get availableEras => [
        'Semua',
        'Kemerdekaan & Diplomasi',
        'Revolusi Kemerdekaan',
        'Perlawanan Kerajaan / Daerah',
        'Pendidikan & Emansipasi',
      ];

  List<HeroModel> get favoriteHeroes =>
      _heroes.where((h) => _favoriteIds.contains(h.id)).toList();

  /// Pahlawan Unggulan Hari Ini (ditentukan berdasarkan hari dalam tahun)
  HeroModel get featuredHero {
    final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
    final index = dayOfYear % _heroes.length;
    return _heroes[index];
  }

  /// Daftar pahlawan setelah difilter dan diurutkan
  List<HeroModel> get filteredHeroes {
    return _heroes.where((hero) {
      // Filter teks pencarian
      final query = _searchQuery.trim().toLowerCase();
      final matchQuery = query.isEmpty ||
          hero.name.toLowerCase().contains(query) ||
          hero.knownAs.toLowerCase().contains(query) ||
          hero.originCity.toLowerCase().contains(query) ||
          hero.originProvince.toLowerCase().contains(query) ||
          hero.shortBio.toLowerCase().contains(query);

      // Filter wilayah
      final matchRegion = _selectedRegion == 'Semua' || hero.regionGroup == _selectedRegion;

      // Filter era
      final matchEra = _selectedEra == 'Semua' || hero.struggleEra == _selectedEra;

      return matchQuery && matchRegion && matchEra;
    }).toList()
      ..sort((a, b) {
        switch (_sortMode) {
          case HeroSortMode.nameAsc:
            return a.name.compareTo(b.name);
          case HeroSortMode.nameDesc:
            return b.name.compareTo(a.name);
          case HeroSortMode.birthYearAsc:
            return _extractYear(a.birthDate).compareTo(_extractYear(b.birthDate));
          case HeroSortMode.birthYearDesc:
            return _extractYear(b.birthDate).compareTo(_extractYear(a.birthDate));
        }
      });
  }

  int _extractYear(String dateStr) {
    final match = RegExp(r'\b\d{4}\b').firstMatch(dateStr);
    return match != null ? int.tryParse(match.group(0)!) ?? 0 : 0;
  }

  // Actions
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedRegion(String region) {
    _selectedRegion = region;
    notifyListeners();
  }

  void setSelectedEra(String era) {
    _selectedEra = era;
    notifyListeners();
  }

  void setSortMode(HeroSortMode mode) {
    _sortMode = mode;
    notifyListeners();
  }

  void toggleFavorite(String heroId) {
    if (_favoriteIds.contains(heroId)) {
      _favoriteIds.remove(heroId);
    } else {
      _favoriteIds.add(heroId);
    }
    notifyListeners();
  }

  bool isFavorite(String heroId) => _favoriteIds.contains(heroId);

  void resetFilters() {
    _searchQuery = '';
    _selectedRegion = 'Semua';
    _selectedEra = 'Semua';
    _sortMode = HeroSortMode.nameAsc;
    notifyListeners();
  }

  // Ringkasan Statistik
  int get totalHeroes => _heroes.length;
  int get totalFavorites => _favoriteIds.length;
  int get totalRegions => availableRegions.length - 1; // tanpa 'Semua'
}
