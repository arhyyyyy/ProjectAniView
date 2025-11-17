import 'package:aniview/ui/viewmodels/anime_viewmodel.dart';
import 'package:aniview/ui/views/pages/anime_detail_screen_page.dart';
import 'package:aniview/ui/widgets/app_drawer.dart' show AppDrawer;
import 'package:aniview/ui/widgets/latest_anime_grid.dart';
import 'package:aniview/ui/widgets/search.dart';
import 'package:aniview/ui/widgets/top_anime_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../themes/colors.dart';
import '../../widgets/anime_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _initialized = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      final vm = context.read<AnimeViewModel>();

      Future.microtask(() {
        vm.fetchTopAnime();
        vm.fetchLatestAnime();
      });

      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AnimeViewModel>();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.bluePastel,
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.bluePastel,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: AppColors.navy, size: 28),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Row(
          children: [
            const SizedBox(width: 4),
            Image.asset("assets/logo.png", width: 50, height: 50),
            const SizedBox(width: 8),
            Text(
              "AniView",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.navy,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none, color: AppColors.navy),
          )
        ],
      ),
      body: vm.state == ViewState.busy
          ? const Center(child: CircularProgressIndicator())
          : vm.state == ViewState.error
              ? Center(child: Text("Error: ${vm.errorMessage}"))
              : RefreshIndicator(
                  onRefresh: () async {
                    await vm.fetchTopAnime();
                    await vm.fetchLatestAnime();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppSearchBar(),
                        const SizedBox(height: 18),
                        if (vm.topAnimes.isNotEmpty) ...[
                          Text(
                            "Popular Now",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.navy,
                            ),
                          ),
                          const SizedBox(height: 12),
                          AnimeSlider(animes: vm.topAnimes.take(6).toList()),
                          const SizedBox(height: 18),
                        ],

                        Text(
                          "Latest Updates",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.navy,
                          ),
                        ),
                        const SizedBox(height: 12),
                        LatestAnimeGrid(
                          items: vm.latestAnimes,
                         onTap: (anime) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AnimeDetailScreen(malId: anime.malId),
                            ),
                          );
                        },
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Top Anime",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.navy,
                          ),
                        ),
                        const SizedBox(height: 12),
                      TopAnimeGrid(
                        items: vm.topAnimes,
                        onTap: (anime) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AnimeDetailScreen(malId: anime.malId),
                            ),
                          );
                        },
                      ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
    );
  }
}