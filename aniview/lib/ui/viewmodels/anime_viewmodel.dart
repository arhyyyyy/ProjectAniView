// lib/ui/viewmodels/anime_viewmodel.dart
import 'package:aniview/data/repo/anime_repository.dart';
import 'package:flutter/material.dart';
import '../../data/models/anime_model.dart';

enum ViewState { idle, busy, error }

class AnimeViewModel extends ChangeNotifier {
  final AnimeRepository repository;

  AnimeViewModel({required this.repository});

  ViewState _state = ViewState.idle;
  String? _errorMessage;

  // TOP Anime
  List<AnimeModel> _animes = [];
  List<AnimeModel> get animes => _animes;

  // ⭐ ADD THIS — getter supaya HomePage bisa akses topAnimes
  List<AnimeModel> get topAnimes => _animes;

  // Latest Anime
  List<AnimeModel> _latestAnimes = [];
  List<AnimeModel> get latestAnimes => _latestAnimes;

  ViewState get state => _state;
  String? get errorMessage => _errorMessage;

  // 🚀 Fetch Top Anime
  Future<void> fetchTopAnime({int page = 1}) async {
    _setState(ViewState.busy);
    try {
      final data = await repository.getTopAnime(page: page);
      _animes = data;
      _setState(ViewState.idle);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(ViewState.error);
    }
  }

  // ⭐ Fetch Latest Anime
  Future<void> fetchLatestAnime() async {
    _setState(ViewState.busy);
    try {
      final data = await repository.getLatestAnime();
      _latestAnimes = data;
      _setState(ViewState.idle);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(ViewState.error);
    }
  }

  // 🔍 Search Anime
  Future<void> search(String query) async {
    _setState(ViewState.busy);
    try {
      final data = await repository.searchAnime(query);
      _animes = data;
      _setState(ViewState.idle);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(ViewState.error);
    }
  }

  // 🎛 State Handler
  void _setState(ViewState s) {
    _state = s;
    notifyListeners();
  }
}
