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
  List<Anime> _animes = [];

  ViewState get state => _state;
  String? get errorMessage => _errorMessage;
  List<Anime> get animes => _animes;

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
