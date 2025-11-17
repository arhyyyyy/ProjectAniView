// lib/main.dart
import 'package:aniview/data/repo/auth_repository.dart';
import 'package:aniview/ui/splash/splashscreen.dart';
import 'package:aniview/ui/viewmodels/login_viewmodel.dart';
import 'package:aniview/ui/viewmodels/profile_viewmodel.dart';
import 'package:aniview/ui/viewmodels/register_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'di/locator.dart';
import 'ui/viewmodels/anime_viewmodel.dart';
import 'ui/viewmodels/auth_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        ChangeNotifierProvider<AuthViewModel>(
          create: (_) => locator<AuthViewModel>(),
        ),
        ChangeNotifierProvider<ProfileViewModel>(
          create: (_) => locator<ProfileViewModel>(),
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterViewModel(locator<AuthRepository>()),
        ),
        ChangeNotifierProvider<LoginViewModel>(
          create: (_) => LoginViewModel(locator<AuthRepository>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AniLive',
        home: const SplashScreen(),
      ),
    );
  }
}
