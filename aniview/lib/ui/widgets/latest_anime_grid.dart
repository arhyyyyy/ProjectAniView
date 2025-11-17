import 'package:aniview/ui/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:aniview/data/models/anime_model.dart';

class LatestAnimeGrid extends StatelessWidget {
  final List<AnimeModel> items;
  final Function(AnimeModel) onTap;

  const LatestAnimeGrid({
    super.key,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) {
        final anime = items[index];

        return GestureDetector(
          onTap: () => onTap(anime),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.softGray,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IMAGE
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(14)),
                  child: Image.network(
                    anime.imageUrl,
                    height: 170,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) {
                      return Container(
                        height: 170,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.broken_image, size: 40),
                      );
                    },
                  ),
                ),

                // TITLE
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    anime.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),

                // SCORE
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        anime.score != null
                            ? anime.score!.toStringAsFixed(1)
                            : "-",
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),

                // TYPE + EPS
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Text(
                    "${anime.type ?? 'N/A'} • ${anime.episodes ?? '?'} eps",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // YEAR
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    anime.year != null ? anime.year.toString() : "Unknown Year",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
