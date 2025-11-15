// lib/di/locator.dart
import 'package:aniview/data/repo/anime_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../core/services/api_service.dart';
import '../ui/viewmodels/anime_viewmodel.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Services
  locator.registerLazySingleton<ApiService>(() => ApiService(client: http.Client()));

  // Repositories
  locator.registerLazySingleton<AnimeRepository>(() => AnimeRepository(apiService: locator()));

  // ViewModels
  locator.registerFactory<AnimeViewModel>(() => AnimeViewModel(repository: locator()));
}
