import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/pahlawan_controller.dart';
import '../../utils/app_theme.dart';
import '../widgets/hero_card.dart';
import '../widgets/search_filter_bar.dart';

class HeroListScreen extends StatelessWidget {
  const HeroListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PahlawanController>();
    final heroes = controller.filteredHeroes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pahlawan Nasional'),
        actions: [
          if (controller.searchQuery.isNotEmpty ||
              controller.selectedRegion != 'Semua' ||
              controller.selectedEra != 'Semua')
            TextButton.icon(
              onPressed: () => controller.resetFilters(),
              icon: const Icon(Icons.refresh_rounded, size: 16, color: AppTheme.primaryRed),
              label: const Text(
                'Reset',
                style: TextStyle(color: AppTheme.primaryRed, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter Bar
          const SearchFilterBar(),

          // Info Jumlah Hasil
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Menampilkan ${heroes.length} dari ${controller.allHeroes.length} Pahlawan',
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textMuted,
                  ),
                ),
                if (controller.selectedRegion != 'Semua')
                  Text(
                    'Wilayah: ${controller.selectedRegion}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryRed,
                    ),
                  ),
              ],
            ),
          ),

          // List Data Pahlawan (Mekanisme 3b & 3c)
          Expanded(
            child: heroes.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search_off_rounded, size: 64, color: Colors.grey.shade400),
                          const SizedBox(height: 16),
                          const Text(
                            'Pahlawan Tidak Ditemukan',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Coba ubah kata kunci pencarian atau reset filter wilayah Anda.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryRed,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () => controller.resetFilters(),
                            child: const Text('Reset Filter'),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 4, bottom: 24),
                    itemCount: heroes.length,
                    itemBuilder: (context, index) {
                      final hero = heroes[index];
                      return HeroCard(hero: hero);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
