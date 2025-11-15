// lib/ui/widgets/anime_slider.dart
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../data/models/anime_model.dart';
import '../themes/colors.dart';

class AnimeSlider extends StatelessWidget {
  final List<AnimeModel> animes;
  const AnimeSlider({super.key, required this.animes});

  @override
  Widget build(BuildContext context) {
    if (animes.isEmpty) {
      return const SizedBox.shrink();
    }

    return CarouselSlider.builder(
      itemCount: animes.length,
      itemBuilder: (context, index, realIdx) {
        final anime = animes[index];
        return GestureDetector(
          onTap: () {
            
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if ((anime.imageUrl).isNotEmpty)
                  Image.network(
                    anime.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (c, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: AppColors.bluePastel,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (_, _, _) => Container(
                      color: AppColors.bluePastel,
                      child: const Center(child: Icon(Icons.broken_image)),
                    ),
                  )
                else
                  Container(color: AppColors.bluePastel),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: .6),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            anime.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              shadows: [Shadow(color: Colors.black26, blurRadius: 4)],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (anime.score != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.star, size: 14, color: Colors.amber),
                                const SizedBox(width: 4),
                                Text(
                                  anime.score!.toString(),
                                  style: const TextStyle(color: Colors.white, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: false,
        viewportFraction: 1,
        disableCenter: true,
      ),
    );
  }
}
