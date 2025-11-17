// lib/ui/views/anime/anime_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/anime_model.dart';
import '../../../data/repo/anime_repository.dart';
import '../../../core/services/api_service.dart';
import '../../viewmodels/anime_detail_viewmodel.dart';
import '../../themes/colors.dart';

class AnimeDetailScreen extends StatelessWidget {
  final int malId;

  const AnimeDetailScreen({
    super.key,
    required this.malId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AnimeDetailViewModel(
        repository: AnimeRepository(apiService: ApiService()),
      )..fetchAnimeDetail(malId),
      child: Scaffold(
        backgroundColor: AppColors.bluePastel,
        body: Consumer<AnimeDetailViewModel>(
          builder: (context, vm, _) {
            if (vm.state == AnimeDetailState.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (vm.state == AnimeDetailState.error) {
              return Center(
                  child: Text(
                "Error: ${vm.errorMessage}",
                style: const TextStyle(color: Colors.red),
              ));
            }

            final AnimeModel anime = vm.anime!;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  backgroundColor: AppColors.bluePastel,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      anime.title,
                      style: const TextStyle(
                        shadows: [Shadow(blurRadius: 4)],
                      ),
                    ),
                    background: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            anime.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: .6),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _infoItem(Icons.star, "Score",
                                    anime.score?.toString() ?? "-"),

                                _infoItem(Icons.movie, "Episodes",
                                    anime.episodes?.toString() ?? "-"),

                                _infoItem(Icons.calendar_month, "Year",
                                    anime.year?.toString() ?? "-"),

                                _infoItem(Icons.category, "Type",
                                    anime.type ?? "-"),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (anime.genres.isNotEmpty)
                          Text(
                            "Genres",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.navy,
                            ),
                          ),
                        const SizedBox(height: 8),
                        if (anime.genres.isNotEmpty)
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: anime.genres
                                .map((g) => Chip(
                                      label: Text(g),
                                      backgroundColor: AppColors.navy,
                                      labelStyle: const TextStyle(
                                          color: Colors.white),
                                    ))
                                .toList(),
                          ),
                        const SizedBox(height: 24),
                        Text(
                          "Synopsis",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.navy,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          anime.synopsis.isNotEmpty
                              ? anime.synopsis
                              : "No synopsis available.",
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 30),
                        if (anime.trailerUrl != null)
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.navy,
                              minimumSize:
                                  const Size(double.infinity, 52),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              // trailer taruh disni
                            },
                            icon: const Icon(Icons.play_arrow, size: 28, color: AppColors.bluePastel),
                            label: const Text(
                              "Watch Trailer",
                              style: TextStyle(fontSize: 16, color: AppColors.bluePastel),
                            ),
                          ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _infoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 28, color: AppColors.navy),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.navy,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
