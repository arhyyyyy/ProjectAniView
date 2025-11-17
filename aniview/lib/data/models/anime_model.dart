class AnimeModel {
  final int malId;
  final String title;
  final String imageUrl;
  final String synopsis;
  final double? score;
  final int? episodes;
  final String? trailerUrl;
  final List<String> genres;

  final String? type;
  final int? year;

  AnimeModel({
    required this.malId,
    required this.title,
    required this.imageUrl,
    required this.synopsis,
    this.score,
    this.episodes,
    this.trailerUrl,
    this.genres = const [],
    this.type,
    this.year,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    // ================ IMAGE ================
    final images = json["images"] ?? {};
    final jpg = images["jpg"] ?? {};
    final imageUrl = jpg["large_image_url"] ??
        jpg["image_url"] ??
        ""; // prevent null

    // ================ TRAILER (embed_url) ================
    String? trailer;
    if (json["trailer"] != null && json["trailer"]["embed_url"] != null) {
      trailer = json["trailer"]["embed_url"];
    }

    // ================ GENRES ================
    final genresList = <String>[];
    if (json["genres"] is List) {
      for (var g in json["genres"]) {
        if (g["name"] != null) genresList.add(g["name"]);
      }
    }

    // ================ TYPE ================
    final type = json["type"];

    // ================ YEAR (fallback aired.year) ================
    final year = json["year"] ??
        json["aired"]?["prop"]?["from"]?["year"];

    // ================ TITLE ================
    final title = json["title"] ??
        json["title_english"] ??
        json["title_japanese"] ??
        "Unknown";

    return AnimeModel(
      malId: json["mal_id"] ?? 0,
      title: title,
      imageUrl: imageUrl,
      synopsis: json["synopsis"] ?? "-",
      score: json["score"] != null
          ? (json["score"] as num).toDouble()
          : null,
      episodes: json["episodes"],
      trailerUrl: trailer,
      genres: genresList,
      type: type,
      year: year,
    );
  }
}
