// lib/data/models/anime_model.dart
class Anime {
  final int malId;
  final String title;
  final String imageUrl;
  final String synopsis;
  final double? score;
  final int? episodes;
  final String? trailerUrl;
  final List<String> genres;

  Anime({
    required this.malId,
    required this.title,
    required this.imageUrl,
    required this.synopsis,
    this.score,
    this.episodes,
    this.trailerUrl,
    this.genres = const [],
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    final images = json['images'] ?? {};
    final jpg = images['jpg'] ?? {};
    final imageUrl = jpg['image_url'] ?? jpg['large_image_url'] ?? '';

    // trailer may be nested
    String? trailer;
    if (json['trailer'] != null && json['trailer']['url'] != null) {
      trailer = json['trailer']['url'];
    }

    final genresList = <String>[];
    if (json['genres'] != null && json['genres'] is List) {
      for (var g in json['genres']) {
        if (g['name'] != null) genresList.add(g['name']);
      }
    }

    return Anime(
      malId: json['mal_id'] ?? json['id'] ?? 0,
      title: json['title'] ?? json['title_english'] ?? 'Unknown',
      imageUrl: imageUrl as String,
      synopsis: json['synopsis'] ?? '',
      score: (json['score'] != null) ? (json['score'] as num).toDouble() : null,
      episodes: json['episodes'],
      trailerUrl: trailer,
      genres: genresList,
    );
  }
}
