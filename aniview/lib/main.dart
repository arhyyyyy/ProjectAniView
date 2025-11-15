// lib/main.dart
import 'package:aniview/ui/splash/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'di/locator.dart';
import 'ui/viewmodels/anime_viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const AniLiveApp());
}

class AniLiveApp extends StatelessWidget {
  const AniLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AnimeViewModel>(
          create: (_) => locator<AnimeViewModel>()..fetchTopAnime(),
        ),
      ],
      child: MaterialApp(
        title: 'AniLive',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
