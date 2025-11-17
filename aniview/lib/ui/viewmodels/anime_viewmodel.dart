import 'package:aniview/data/repo/anime_repository.dart';
import 'package:flutter/material.dart';
import '../../data/models/anime_model.dart';

enum ViewState { idle, busy, error }

class AnimeViewModel extends ChangeNotifier {
  final AnimeRepository repository;

  AnimeViewModel({required this.repository});
  ViewState _state = ViewState.idle;
  String? _errorMessage;
  List<AnimeModel> _animes = [];
  List<AnimeModel> get animes => _animes;
  List<AnimeModel> get topAnimes => _animes;
  List<AnimeModel> _latestAnimes = [];
  List<AnimeModel> get latestAnimes => _latestAnimes;

  ViewState get state => _state;
  String? get errorMessage => _errorMessage;


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


  void _setState(ViewState s) {
    _state = s;
    notifyListeners();
  }
}
