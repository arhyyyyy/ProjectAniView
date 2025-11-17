import 'package:flutter/material.dart';
import '../../data/models/anime_model.dart';
import '../../data/repo/anime_repository.dart';

enum AnimeDetailState { idle, loading, error }

class AnimeDetailViewModel extends ChangeNotifier {
  final AnimeRepository repository;

  AnimeDetailViewModel({required this.repository});

  AnimeDetailState state = AnimeDetailState.idle;
  String? errorMessage;
  AnimeModel? anime;

  Future<void> fetchAnimeDetail(int malId) async {
    try {
      state = AnimeDetailState.loading;
      notifyListeners();

      anime = await repository.getAnimeDetail(malId);

      state = AnimeDetailState.idle;
    } catch (e) {
      state = AnimeDetailState.error;
      errorMessage = e.toString();
    }

    notifyListeners();
  }
}
