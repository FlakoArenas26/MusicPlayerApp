import 'package:get_it/get_it.dart';
import 'package:music_player/src/bloc/favorites/favorites_bloc.dart';
import 'package:music_player/src/bloc/home/home_bloc.dart';
import 'package:music_player/src/bloc/player/player_bloc.dart';
import 'package:music_player/src/bloc/recents/recents_bloc.dart';
import 'package:music_player/src/bloc/song/song_bloc.dart';
import 'package:music_player/src/bloc/theme/theme_bloc.dart';
import 'package:music_player/src/data/repositories/favorites_repository.dart';
import 'package:music_player/src/data/repositories/home_repository.dart';
import 'package:music_player/src/data/repositories/player_repository.dart';
import 'package:music_player/src/data/repositories/recents_repository.dart';
import 'package:music_player/src/data/repositories/song_repository.dart';
import 'package:music_player/src/data/repositories/theme_repository.dart';
import 'package:on_audio_query/on_audio_query.dart';

final sl = GetIt.instance;

void init() {
  // Bloc
  sl.registerFactory(() => ThemeBloc(repository: sl()));
  sl.registerFactory(() => HomeBloc(repository: sl()));
  sl.registerFactory(() => PlayerBloc(repository: sl()));
  sl.registerFactory(() => SongBloc(repository: sl()));
  sl.registerFactory(() => FavoritesBloc(repository: sl()));
  sl.registerFactory(() => RecentsBloc(repository: sl()));

  // Repository
  sl.registerLazySingleton(() => ThemeRepository());
  sl.registerLazySingleton(() => HomeRepository());
  sl.registerLazySingleton(() => PlayerRepository());
  sl.registerLazySingleton(() => SongRepository());
  sl.registerLazySingleton(() => FavoritesRepository());
  sl.registerLazySingleton(() => RecentsRepository());

  // Third Party
  sl.registerLazySingleton(() => OnAudioQuery());
}