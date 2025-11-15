import '../../core/services/api_service.dart';
import '../models/anime_model.dart';

class AnimeRepository {
  final ApiService apiService;
  AnimeRepository({required this.apiService});

  Future<List<Anime>> getTopAnime({int page = 1}) =>
      apiService.fetchTopAnime(page: page);

  Future<List<Anime>> searchAnime(String query) =>
      apiService.searchAnime(query);

  Future<Anime> getAnimeDetail(int malId) =>
      apiService.getAnimeDetail(malId);
}
