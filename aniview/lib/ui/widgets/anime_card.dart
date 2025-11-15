// lib/ui/widgets/anime_card.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/anime_model.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;
  const AnimeCard({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: CachedNetworkImage(
            imageUrl: anime.imageUrl,
            width: 56,
            height: 80,
            fit: BoxFit.cover,
            placeholder: (c, _) => const SizedBox(width: 56, height: 80, child: Center(child: CircularProgressIndicator())),
            errorWidget: (c, _, __) => const Icon(Icons.broken_image),
          ),
        ),
        title: Text(anime.title),
        subtitle: Text(
          anime.synopsis,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
       
        },
      ),
    );
  }
}
