import '../../core/services/api_service.dart';
import '../models/anime_model.dart';

class AnimeRepository {
  final ApiService apiService;
  AnimeRepository({required this.apiService});

  Future<List<AnimeModel>> getTopAnime({int page = 1}) =>
      apiService.fetchTopAnime(page: page);

  Future<List<AnimeModel>> searchAnime(String query) =>
      apiService.searchAnime(query);

  Future<AnimeModel> getAnimeDetail(int malId) =>
      apiService.getAnimeDetail(malId);

  Future<List<AnimeModel>> getLatestAnime() =>
      apiService.fetchLatestAnime();
}
