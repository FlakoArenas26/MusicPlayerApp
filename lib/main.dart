import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player/src/bloc/player/player_bloc.dart';
import 'package:music_player/src/bloc/recents/recents_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:music_player/src/app.dart';
import 'package:music_player/src/bloc/favorites/favorites_bloc.dart';
import 'package:music_player/src/bloc/home/home_bloc.dart';
import 'package:music_player/src/bloc/song/song_bloc.dart';
import 'package:music_player/src/bloc/theme/theme_bloc.dart';
import 'package:music_player/src/data/services/hive_box.dart';
import 'package:music_player/src/service_locator.dart';

Future<void> main() async {
  // Initialize flutter engine
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  init();

  // Set portrait orientation
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  // Ask for permission to acces media if not granted
  if (!await Permission.mediaLibrary.isGranted) {
    await Permission.mediaLibrary.request();
  }

  // Ask for notification permission if not granted
  if (!await Permission.notification.isGranted) {
    await Permission.notification.request();
  }

  // Initialize hive
  await Hive.initFlutter();
  await Hive.openBox(HiveBox.boxName);

  // Initialize audio service
  await JustAudioBackground.init(
    androidNotificationChannelName: 'Music Player Audio',
    androidNotificationOngoing: true,
    androidStopForegroundOnPause: true,
  );

  // Run app
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<HomeBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ThemeBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SongBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<FavoritesBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<PlayerBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<RecentsBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
