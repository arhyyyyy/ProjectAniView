// lib/core/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/models/anime_model.dart';

class ApiService {
  static const String _baseUrl = 'https://api.jikan.moe/v4';

  final http.Client client;
  ApiService({http.Client? client}) : client = client ?? http.Client();

  Future<List<AnimeModel>> fetchTopAnime({int page = 1}) async {
    final url = Uri.parse('$_baseUrl/top/anime?page=$page');
    final res = await client.get(url);
    if (res.statusCode == 200) {
      final map = json.decode(res.body);
      final List data = map['data'] ?? [];
      return data.map((e) => AnimeModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load top anime: ${res.statusCode}');
    }
  }

  Future<List<AnimeModel>> searchAnime(String query) async {
    final url = Uri.parse('$_baseUrl/anime?q=${Uri.encodeQueryComponent(query)}&limit=30');
    final res = await client.get(url);
    if (res.statusCode == 200) {
      final map = json.decode(res.body);
      final List data = map['data'] ?? [];
      return data.map((e) => AnimeModel.fromJson(e)).toList();
    } else {
      throw Exception('Search failed: ${res.statusCode}');
    }
  }

  // ⭐ NEW: Fetch Latest Anime (Season Ongoing)
  Future<List<AnimeModel>> fetchLatestAnime() async {
    final url = Uri.parse('$_baseUrl/seasons/now');
    final res = await client.get(url);

    if (res.statusCode == 200) {
      final map = json.decode(res.body);
      final List data = map['data'] ?? [];
      return data.map((e) => AnimeModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load latest anime: ${res.statusCode}');
    }
  }

  Future<AnimeModel> getAnimeDetail(int malId) async {
    final url = Uri.parse('$_baseUrl/anime/$malId/full');
    final res = await client.get(url);
    if (res.statusCode == 200) {
      final map = json.decode(res.body);
      final data = map['data'];
      return AnimeModel.fromJson(data);
    } else {
      throw Exception('Failed to load detail: ${res.statusCode}');
    }
  }

  void dispose() {
    client.close();
  }
}
