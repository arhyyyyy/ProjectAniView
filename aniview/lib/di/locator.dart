// lib/di/locator.dart
import 'package:aniview/data/repo/anime_repository.dart';
import 'package:aniview/data/repo/auth_repository.dart';
import 'package:aniview/data/repo/profile_repository.dart';
import 'package:aniview/data/repo/user_repository.dart';
import 'package:aniview/ui/viewmodels/edit_profile_viewmodel.dart';
import 'package:aniview/ui/viewmodels/profile_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../core/services/api_service.dart';
import '../ui/viewmodels/anime_viewmodel.dart';
import '../ui/viewmodels/auth_viewmodel.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<ApiService>(
    () => ApiService(client: http.Client()),
  );

  locator.registerLazySingleton<UserRepository>(
    () => UserRepository(firestore: FirebaseFirestore.instance),
  );

  locator.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(),
  );

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepository(),
  );

  locator.registerLazySingleton<AnimeRepository>(
    () => AnimeRepository(apiService: locator()),
  );
  locator.registerLazySingleton<AuthViewModel>(
    () => AuthViewModel(),
  );

  locator.registerFactory<AnimeViewModel>(
    () => AnimeViewModel(repository: locator()),
  );

  locator.registerLazySingleton<ProfileViewModel>(
    () => ProfileViewModel(repository: locator()),
  );

  locator.registerFactory<EditProfileViewModel>(
    () => EditProfileViewModel(
      locator<ProfileRepository>(),
      locator<ProfileViewModel>(),
    ),
  );
}
