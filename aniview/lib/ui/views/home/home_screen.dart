// lib/ui/views/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/anime_viewmodel.dart';
import '../../widgets/anime_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AnimeViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('AniLive')),
      body: Builder(builder: (context) {
        if (vm.state == ViewState.busy) {
          return const Center(child: CircularProgressIndicator());
        } else if (vm.state == ViewState.error) {
          return Center(child: Text('Error: ${vm.errorMessage}'));
        } else if (vm.animes.isEmpty) {
          return const Center(child: Text('No anime found.'));
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: vm.animes.length,
            itemBuilder: (context, idx) {
              final anime = vm.animes[idx];
              return AnimeCard(anime: anime);
            },
          );
        }
      }),
    );
  }
}
